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
  $modules       = {},
) {

  require drupal

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
  }

  exec { "rebuild-drupal-${title}":
    command     => "${drupal::drush_executable} make ${config_file} ${site_file}",
    creates     => $site_file,
    refreshonly => true,
    subscribe   => File[$config_file],
    require     => File[$drupal::drush_executable],
  }

  file { "/var/www/${title}":
    ensure => link,
    target => $site_file,
  }
}
