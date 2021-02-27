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
#   -- deprecated, no longer in use --
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
# [*drush_version*]
#   Set the version (git revision) to be installed.
#
# [*drush_archive_checksum*]
#   Set the checksum of the drush archive to be installed.
#
# [*drush_archive_checksum_type*]
#   Set the checksum type (e.g. `sha256` or `md5`) of the checksum.
#
# [*drush_path*]
#   Set the full path (including filename) where the drush executable should be installed to.
#
# [*drush_concurrency_level*]
#   Set the number of concurrent projects that will be processed at the same time.
#
# [*update_script_path*]
#   Set the path of the script which is executed when the Drupal database needs to run outstanding upgrade tasks.
#
# [*update_script_template*]
#   Set the path to the template file that is used when creating the update script.
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
  Stdlib::Absolutepath $install_dir = $drupal::params::install_dir,
  Stdlib::Absolutepath $config_dir = $drupal::params::config_dir,
  Optional[Stdlib::Absolutepath] $log_dir = $drupal::params::log_dir,  # deprecated, no longer in use
  Stdlib::Absolutepath $www_dir = $drupal::params::www_dir,
  String $www_process = $drupal::params::www_process,
  Array[String] $exec_paths = $drupal::params::exec_paths,
  String $drush_version = $drupal::params::drush_version,
  String $drush_archive_checksum = $drupal::params::drush_archive_checksum,
  String $drush_archive_checksum_type = $drupal::params::drush_archive_checksum_type,
  Stdlib::Absolutepath $drush_path = $drupal::params::drush_path,
  Integer $drush_concurrency_level = $drupal::params::drush_concurrency_level,
  Stdlib::Absolutepath $update_script_path = $drupal::params::update_script_path,
  String $update_script_template = $drupal::params::update_script_template,
) inherits drupal::params {

  class { 'drupal::install': }
}
