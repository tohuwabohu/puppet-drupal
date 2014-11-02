# == Class: drupal
#
# Manage global Drupal configuration settings.
#
# === Parameters
#
# [*package_dir*]
#   Set the directory where all downloaded packages are stored.
#
# [*install_dir*]
#   Set the root directory where the Drupal core and its modules are installed.
#   Note: the modules are installed in parallel to the core and symlinked based on the configured version.
#
# [*config_dir*]
#   Set the root directory where the generated drush makefiles are stored.
#
# [*log_dir*]
#   Set the root directory where the write output of the drush command to.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class drupal (
  $package_dir = $drupal::params::package_dir,
  $install_dir = $drupal::params::install_dir,
  $config_dir  = $drupal::params::config_dir,
  $log_dir     = $drupal::params::log_dir,
) inherits drupal::params {

  validate_absolute_path($package_dir)
  validate_absolute_path($install_dir)
  validate_absolute_path($config_dir)
  validate_absolute_path($log_dir)

  $drush_dir = "${drupal::install_dir}/drush"
  $drush_executable = '/usr/local/bin/drush'

  class { 'drupal::install': }
}
