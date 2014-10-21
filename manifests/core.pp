# == Class: drupal::core
#
# Install a given version of the Drupal core.
#
# === Parameters
#
# [*version*]
#   Set the version to be installed.
#
# [*archive_md5sum*]
#   Set the MD5 checksum of the drupal package (optional).
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
define drupal::core (
  $version,
  $archive_md5sum = undef,
) {

  require drupal

  $drupal_archive = "drupal-${version}"

  exec { "install-${drupal_archive}":
    command => "${drupal::drush_executable} dl ${drupal_archive} --destination=${drupal::install_dir}",
    creates => "${drupal::install_dir}/${drupal_archive}",
    require => File[$drupal::drush_executable],
  }
}
