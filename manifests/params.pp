# Class = '$params
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
  $log_dir = '/var/log/drush'
  $cache_dir = '/var/cache/puppet/archives'
  
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
  
  $drush_version = '6.6.0'
  $drush_archive_md5sum = 'bfe556917f29e2d3c25dda8ecde96281'
  $drush_concurrency_level = 1
  $drush_path = '/usr/local/bin/drush'
  
  $update_script_path = '/usr/local/sbin/drupal-update.sh'
  $update_script_template = 'drupal/drupal-update.sh.erb'
}
