# Class: drupal::params
#
# Default configuration values for the drupal class.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class drupal::params {
  $install_dir = $::osfamily ? {
    default => '/opt/drupal.org',
  }

  $config_dir = $::osfamily ? {
    default => '/etc/drush'
  }

  $log_dir = $::osfamily ? {
    default => '/var/log/drush'
  }

  $www_dir = $::osfamily ? {
    default => '/var/www'
  }

  $www_process = $::osfamily ? {
    default => 'www-data'
  }

  $exec_paths = $::osfamily ? {
    default => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }

  $composer_installer_url = 'https://getcomposer.org/installer'
  $composer_install_dir = $::osfamily ? {
    default => '/usr/local/bin'
  }

  $drush_path = $::osfamily ? {
    default => '/usr/local/bin/drush'
  }
  $drush_concurrency_level = 1
}
