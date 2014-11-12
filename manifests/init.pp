# == Class: drupal
#
# Manage global Drupal configuration settings.
#
# === Parameters
#
# [*install_dir*]
#   Set the root directory where the Drupal core and its modules are installed.
#
# [*config_dir*]
#   Set the root directory where the generated drush makefiles are stored.
#
# [*log_dir*]
#   Set the root directory where the write output of the drush command to.
#
# [*www_dir*]
#   Set the root directory where to create the document root for all managed Drupal sites.
#   Note: as this directory can be shared with other modules, it is not managed.
#
# [*www_process*]
#   Set the name of the process that is executing the Drupal site.
#
# [*exec_paths*]
#   Set the paths used to search for executables when invoking exec resources.
#
# [*drush_concurrency_level*]
#   Set the number of concurrent projects that will be processed at the same time.
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
  $install_dir             = $drupal::params::install_dir,
  $config_dir              = $drupal::params::config_dir,
  $log_dir                 = $drupal::params::log_dir,
  $www_dir                 = $drupal::params::www_dir,
  $www_process             = $drupal::params::www_process,
  $exec_paths              = $drupal::params::exec_paths,
  $drush_concurrency_level = $drupal::params::drush_concurrency_level,
) inherits drupal::params {

  validate_absolute_path($install_dir)
  validate_absolute_path($config_dir)
  validate_absolute_path($log_dir)
  validate_absolute_path($www_dir)

  $drush_dir = "${drupal::install_dir}/drush"
  $drush_executable = '/usr/local/bin/drush'

  class { 'drupal::install': }
}
