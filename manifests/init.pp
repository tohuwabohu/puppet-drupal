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
# [*cache_dir*]
#   Set the path to the directory where to cache downloaded drush archives (like drush).
#
# [*exec_paths*]
#   Set the paths used to search for executables when invoking exec resources.
#
# [*composer_installer_url*]
#   Set the url where to download the composer installer from.
#
# [*composer_path*]
#   Set the full path (including filename) where to install the composer executable.
#
# [*drush_version*]
#   Set the version (git revision) to be installed.
#
# [*drush_path*]
#   Set the full path (including filename) where the drush executable should be installed to.
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
  $cache_dir               = $drupal::params::cache_dir,
  $exec_paths              = $drupal::params::exec_paths,
  $composer_installer_url  = $drupal::params::composer_installer_url,
  $composer_path           = $drupal::params::composer_path,
  $drush_version           = $drupal::params::drush_version,
  $drush_archive_md5sum    = $drupal::params::drush_archive_md5sum,
  $drush_path              = $drupal::params::drush_path,
  $drush_concurrency_level = $drupal::params::drush_concurrency_level,
) inherits drupal::params {

  validate_absolute_path($install_dir)
  validate_absolute_path($config_dir)
  validate_absolute_path($log_dir)
  validate_absolute_path($www_dir)
  validate_absolute_path($cache_dir)
  validate_absolute_path($composer_path)
  validate_absolute_path($drush_path)

  class { 'drupal::install': }
}
