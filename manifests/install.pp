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

  exec { 'install-composer':
    command => "curl -sS ${drupal::composer_installer_url} | php -d suhosin.executor.include.whitelist=phar -- --install-dir=${drupal::composer_install_dir} --filename=composer",
    creates => "${drupal::composer_install_dir}/composer",
    path    => $drupal::exec_paths,
  }

  vcsrepo { $drupal::drush_dir:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/drush-ops/drush.git',
    revision => '6.4.0',
    require  => File[$drupal::install_dir],
  }

  file { $drupal::drush_executable:
    ensure  => link,
    target  => "${drupal::drush_dir}/drush",
    require => Vcsrepo[$drupal::drush_dir],
  }

  exec { "composer --working-dir ${drupal::drush_dir} install":
    environment => "HOME=${::root_home}",
    refreshonly => true,
    subscribe   => Vcsrepo[$drupal::drush_dir],
    require     => [
      Vcsrepo[$drupal::drush_dir],
      Exec['install-composer'],
    ],
  }
}
