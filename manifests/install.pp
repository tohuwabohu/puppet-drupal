# == Class: drupal::install
#
# Install all requirements of the Drupal module.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class drupal::install inherits drupal {

  require composer

  $drush_archive = "drush-${drupal::drush_version}"
  $drush_download_url = "https://github.com/drush-ops/drush/archive/${drupal::drush_version}.tar.gz"
  $drush_install_dir = "${drupal::install_dir}/${drush_archive}"

  file { $drupal::install_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { $drupal::config_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { $drupal::log_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  archive { $drush_archive:
    ensure           => present,
    url              => $drush_download_url,
    digest_string    => $drupal::drush_archive_md5sum,
    target           => $drupal::install_dir,
    src_target       => $drupal::cache_dir,
    timeout          => 60,
    follow_redirects => true,
    require          => [
      File[$drupal::install_dir],
      File[$drupal::cache_dir]
    ],
  }

  exec { 'install-drush-dependencies':
    command     => "composer --working-dir=${drush_install_dir} install",
    creates     => "${drush_install_dir}/vendor",
    path        => $drupal::exec_paths,
    environment => "HOME=${::root_home}",
    require     => Archive[$drush_archive],
  }

  file { $drupal::drush_path:
    ensure  => link,
    target  => "${drush_install_dir}/drush",
    require => Exec['install-drush-dependencies'],
  }

  file { $drupal::update_script_path:
    ensure  => file,
    content => template($drupal::update_script_template),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
}
