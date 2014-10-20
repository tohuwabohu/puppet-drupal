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

  exec { 'install-composer':
    command => "/usr/bin/curl -sS ${composer_installer_url} | /usr/bin/php -d suhosin.executor.include.whitelist=phar -- --install-dir=${composer_install_dir} --filename=${composer_exec_filename}",
    creates => "${composer_install_dir}/${composer_exec_filename}",
  }
}
