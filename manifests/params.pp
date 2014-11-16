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

  $cache_dir = $::osfamily ? {
    default => '/var/cache/puppet/archives'
  }

  $exec_paths = $::osfamily ? {
    default => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }

  $curl_package_name = $::osfamily ? {
    default => 'curl'
  }

  $php_cli_package_name = $::osfamily ? {
    default => 'php5-cli'
  }

  $composer_installer_url = 'https://getcomposer.org/installer'
  $composer_path = $::osfamily ? {
    default => '/usr/local/bin/composer'
  }

  $drush_version = '6.4.0'
  $drush_archive_md5sum = '86f2772aaab4c112149490e5ac4ded59'
  $drush_path = $::osfamily ? {
    default => '/usr/local/bin/drush'
  }
  $drush_concurrency_level = 1
}
