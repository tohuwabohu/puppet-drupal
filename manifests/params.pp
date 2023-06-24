# == Class: drupal::params
#
# Default configuration values for the `drupal` class.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2016 Martin Meinhold, unless otherwise noted.
#
class drupal::params {
  $install_dir = '/opt/drupal.org'
  $config_dir = '/etc/drush'

  # deprecated, no longer in use
  $log_dir = '/var/log/drush'

  $www_dir = '/var/www'
  $www_process = 'www-data'

  $exec_paths = [
    '/usr/local/sbin',
    '/usr/local/bin',
    '/usr/sbin',
    '/usr/bin',
    '/sbin',
    '/bin'
  ]

  $drush_version = '8.4.12'
  $drush_archive_checksum = '62d0fd943eb6d4b24900cfe278be0a5af638a3852aa37f855a08c660675041ac'
  $drush_archive_checksum_type = 'sha256'
  $drush_concurrency_level = 1
  $drush_path = '/usr/local/bin/drush'

  $update_script_path = '/usr/local/sbin/drupal-update.sh'
  $update_script_template = 'drupal/drupal-update.sh.erb'
}
