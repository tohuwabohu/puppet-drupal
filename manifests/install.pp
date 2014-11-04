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

  $composer_installer_url = 'https://getcomposer.org/installer'
  $composer_exec_filename = 'composer'
  $composer_install_dir = $::osfamily ? {
    default => '/usr/local/bin'
  }

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
    command => "curl -sS ${composer_installer_url} | php -d suhosin.executor.include.whitelist=phar -- --install-dir=${composer_install_dir} --filename=${composer_exec_filename}",
    creates => "${composer_install_dir}/${composer_exec_filename}",
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

  exec { 'install-drush-dependencies':
    command     => "${composer_install_dir}/${composer_exec_filename} install",
    cwd         => $drupal::drush_dir,
    environment => "HOME=${::root_home}",
    refreshonly => true,
    subscribe   => Vcsrepo[$drupal::drush_dir],
    require     => [
      Vcsrepo[$drupal::drush_dir],
      Exec['install-composer'],
    ],
  }
}
