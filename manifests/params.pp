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
  $package_dir = $::osfamily ? {
    default => '/var/cache/puppet/archives',
  }

  $install_dir = $::osfamily ? {
    default => '/opt/drupal.org',
  }

  $config_dir = $::osfamily ? {
    default => '/etc/drupal'
  }

  $log_dir = $::osfamily ? {
    default => '/var/log/drush'
  }

  $www_dir = $::osfamily ? {
    default => '/var/www'
  }
}
