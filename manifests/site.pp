# Define: drupal::site
#
# Manage a Drupal site.
#
# === Parameters
#
# [*core_version*]
#   Set the version of the Drupal core to be installed.
#
# [*document_root*]
#   Set the path to the document root. This will result in a symbolic link pointing to a directory containing all
#   modules and themes as configured.
#
# [*modules*]
#   Set modules to be installed along with the core (optional). See the README file for examples.
#
# [*themes*]
#   Set themes to be installed along with the core (optional). See the README file for examples.
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
  $core_version,
  $document_root = undef,
  $modules       = {},
  $themes        = {},
) {

  require drupal

  $real_document_root = pick($document_root, "${drupal::www_dir}/${title}")
  validate_absolute_path($real_document_root)

  $regex = '(\d+).(\d+)$'
  $core_major_version = regsubst($core_version, $regex, '\1', 'I')

  $makefile_content = template('drupal/drush.make.erb')
  $makefile_md5 = md5($makefile_content)

  $config_file = "${drupal::config_dir}/${title}.make"
  $site_file = "${drupal::install_dir}/${title}-${makefile_md5}"

  file { $config_file:
    ensure  => file,
    content => $makefile_content,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Exec["rebuild-drupal-${title}"],
  }

  exec { "rebuild-drupal-${title}":
    command => "${drupal::drush_executable} make -v ${config_file} ${site_file} >> ${drupal::log_dir}/${title}.log 2>&1",
    creates => $site_file,
    require => File[$drupal::drush_executable],
  }

  file { $real_document_root:
    ensure => link,
    target => $site_file,
  }
}
