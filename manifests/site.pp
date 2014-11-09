# Define: drupal::site
#
# Manage a Drupal site.
#
# === Parameters
#
# [*core_version*]
#   Set the version of the Drupal core to be installed.
#
# [*modules*]
#   Set modules to be installed along with the core (optional). See the README file for examples.
#
# [*themes*]
#   Set themes to be installed along with the core (optional). See the README file for examples.
#
# [*libraries*]
#   Set libraries to be installed (optional). See the README file for examples.
#
# [*settings_content*]
#   Set the content of the `settings.php`.
#
# [*files_target*]
#   Set the target of the `files` directory.
#
# [*files_manage*]
#   Set to `true` to manage the `files` directory of a Drupal site kept outside of the actual Drupal installation. Set
#   to `false` if the directory is already managed somewhere else.
#
# [*makefile_content*]
#   Set content of the makefile to be used (optional). Other parameters used to generate a makefile (`core_version`,
#   `modules` and `themes`) are ignored when this one is used..
#
# [*document_root*]
#   Set the path to the document root. This will result in a symbolic link pointing to a directory containing all
#   modules and themes as configured.
#
# [*timeout*]
#   Set the timeout in seconds of the rebuild site command.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
define drupal::site (
  $core_version     = undef,
  $modules          = {},
  $themes           = {},
  $libraries        = {},
  $settings_content = undef,
  $files_target     = undef,
  $files_manage     = true,
  $makefile_content = undef,
  $document_root    = undef,
  $timeout          = undef,
) {

  require drupal

  $real_document_root = pick($document_root, "${drupal::www_dir}/${title}")
  validate_absolute_path($real_document_root)

  # TODO: default data location should be configurable
  $real_files_target = pick($files_target, "/var/lib/${title}")
  validate_absolute_path($real_files_target)

  if empty($makefile_content) {
    $core_major_version = regsubst($core_version, '(\d+).(\d+)$', '\1', 'I')
    $real_makefile_content = template('drupal/drush.make.erb')
  }
  else {
    $real_makefile_content = $makefile_content
  }

  $makefile_sha1 = sha1($real_makefile_content)
  $config_file = "${drupal::config_dir}/${title}.make"
  # TODO: rename me
  $site_file = "${drupal::install_dir}/${title}-${makefile_sha1}"

  file { $config_file:
    ensure  => file,
    content => $real_makefile_content,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
  }

  exec { "rebuild-drupal-${title}":
    command => "${drupal::drush_executable} make -v --concurrency=${drupal::drush_concurrency_level} ${config_file} ${site_file} >> ${drupal::log_dir}/${title}.log 2>&1 || { rm -rf ${site_file}; exit 99; }",
    creates => $site_file,
    timeout => $timeout,
    path    => $drupal::exec_paths,
    require => File[$drupal::drush_executable],
  }

  file { $real_document_root:
    ensure => link,
    target => $site_file,
  }

  if $files_manage {
    # TODO: owner and group should be configurable
    file { $real_files_target:
      ensure => directory,
      owner  => 'www-data',
      group  => 'www-data',
      mode   => '755',
    }
  }

  file { "${site_file}/files":
    ensure  => link,
    target  => $real_files_target,
  }

  #
  # Ensure the order of events
  #

  # first update the Drush makefile
  File[$config_file] ->

  # then rebuild the site (if necessary) ...
  Exec["rebuild-drupal-${title}"] ->

  # then update links to the data directory
  File["${site_file}/files"] ->

  # and if everything goes well - update the document root
  File[$real_document_root]
}
