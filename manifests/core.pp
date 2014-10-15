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

  $archive = "drupal-${version}"
  $archive_url = "http://ftp.drupal.org/files/projects/drupal-${version}.tar.gz"

  archive { $archive:
    ensure        => present,
    checksum      => !empty($archive_md5sum),
    digest_string => $archive_md5sum,
    url           => $archive_url,
    target        => $drupal::install_dir,
    src_target    => $drupal::package_dir,
    require       => [
      File[$drupal::install_dir],
      File[$drupal::package_dir],
    ],
  }
}
