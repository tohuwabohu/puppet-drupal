# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
              
## Unreleased

### Updated

- Drush: 8.0.5 to 8.4.12; this should fix the `Unknown archive format.` error.
- Puppet dependencies: puppetlabs/stdlib and puppet/archive

## [4.0.0](https://github.com/tohuwabohu/puppet-drupal/tree/v4.0.0) (2021-02-27)
                      
### Summary

The only change in this release is the update from the unmaintained `camptocamp/archive` to `puppet/archive`. This
includes the replacement of the private define `archive::download` with recommended public define `archive`.
                        
### Breaking change

- Replace `camptocamp/archive` with `puppet/archive` which is essentially a drop-in replacement
- Replace usage of `archive::download` with `archive`

## [3.3.0](https://github.com/tohuwabohu/puppet-drupal/tree/v3.3.0) (2021-02-27)
                      
### Added

- Puppet data types to `drupal` class and `drupal::site` define; for Puppet 3 users this is a breaking change.

## [3.2.0](https://github.com/tohuwabohu/puppet-drupal/tree/v3.2.0) (2021-02-27)
                      
### Summary

This version updates the build and test infrastructure to catch up with reality. There have been no changes to the
Puppet code itself.

The next major release will replace camptocamp/archive with puppet/archive.

### Added
          
- Mark module compatible with Puppet 6.x and 7.x
- Mark module compatible with latest puppetlabs/stdlib release 

### Changed

- Migrate from travis-ci.org to Github Actions due to pending shutdown :sob:
- Update coverage of Puppet version in unit tests: [3.x, 4.x, 5.x] to [5.x, 6.x, 7.x] 
- Update acceptance tests:
  - Replace Debian 6 and 7 with 9 and 10
  - Replace Ubuntu 12.04 and 14.04 with 18.04 and 20.04
  - Remove outdated Drupal 6 test case
                                         
### Deprecated

- Dependency camptocamp/archive will be replaced with puppet/archive in the next major release 

## 2017-09-22 - Release 3.1.0

Update test infrastructure and add support for Puppet 5.

## 2017-09-22 - Release 3.0.2

Bugfix release which fixes a regression introduced in 3.0.1: it causes the database update script to fail due to 
missing permissions to write into or create the designated log file. After reviewing the code it was concluded the 
log file is not needed as Puppet can capture the log as well. Hence the log redirect was removed and the `log_dir` 
parameter marked as deprecated.

## 2017-09-08 - Release 3.0.1

Bugfix release fixing an issue whereas database updates where not run as the configured process user but `root` instead.

## 2016-03-23 - Release 3.0.0
### Summary

Upgrade Drush from 6.6.0 to 8.0.5 ([issue #9](https://github.com/tohuwabohu/puppet-drupal/issues/9)). This adds support
for Drupal 8.

**Breaking change:** Drush 8 dropped support for PHP 5.3, please ensure at least PHP 5.4 is installed.

#### Improvements

Beginning with version 8.x the Drush project started to publish Drush as a
[phar archive](https://secure.php.net/manual/en/intro.phar.php). This archive contains all necessary dependencies in one
file and makes the usage of composer redundant. To ensure file integrity the checksum is verified post download.

As a result the dependency on [willdurand/composer](https://forge.puppetlabs.com/willdurand/composer) has been dropped
and code like the `cache_dir` parameter has been removed.

On top of that the `drush_archive_md5sum` parameter has been replaced with `drush_archive_checksum` and
`drush_archive_checksum_type`, the default checksum type is now `SHA256`.

## 2016-03-21 - Release 2.0.0
### Summary

**Breaking change:** The module will no longer manage the [composer](https://getcomposer.org/) installation. Instead it
will rely on the [willdurand/composer](https://forge.puppetlabs.com/willdurand/composer) module.

As a consequence, a couple of parameters have been removed from the `drupal` class:

* `curl_package_name`
* `php_cli_package_name`
* `composer_installer_url`
* `composer_path`

If you've used one of the parameters in your Puppet configuration please remove them before upgrading or consider
tweaking the `composer` class.

#### Bugfix

* Installation of composer fails due to missing HOME environment variable ([issue #6](https://github.com/tohuwabohu/puppet-drupal/issues/6))

#### Improvements

* Replace [ripienaar/module_data](https://forge.puppetlabs.com/ripienaar/module_data) with `params.pp`; the module is
  unlikly to work with Puppet 4 (see [Native Puppet 4 Data in Modules](https://www.devco.net/archives/2016/01/08/native-puppet-4-data-in-modules.php))
  and in order to not break Puppet 3 support it is easier to just stick with a simple `params.pp` for the moment

Further more, the test infrastructure has been overhauled:

* Bump gem dependencies to the latest version
* Bump Puppet module dependencies to the latest version
* Update travis test matrix and add support for Puppet 4
* Replace VirtualBox with Docker for acceptance tests
* Remove Debian 6 which is no longer officially supported; Debian 8 has been added instead

## 2015-11-29 - Release 1.2.1
### Summary

Setting up a site from scratch will no longer fail the Puppet run
([issue #3](https://github.com/tohuwabohu/puppet-drupal/issues/3)). The pending database updates are now only applied
if the site has been fully set up.

Puppet-specific limitations caused by the usage of the archive module have been documented as well
([issue #4](https://github.com/tohuwabohu/puppet-drupal/issues/4)).

## 2015-05-17 - Release 1.2.0
### Summary

* E-mails generated by the drush cron command now contain the correct link to the Drupal site, not just `http://default/`.
* Update to Drush 6.6.0
* Update Vagrant boxes (used for acceptance tests only)

## 2015-02-21 - Release 1.1.0
### Summary

* The Drupal site is put into maintenance mode before outstanding database updates are applied
* Workaround suhosin blocking composer execution on Debian 6
* Support Ubuntu 12.04 and 14.04

## 2015-02-01 - Release 1.0.0
### Summary

Initial release.

* Install composer and Drupal drush to do all the heavy-lifting
* Configure a Drupal site based on the configured modules, themes and libraries
* Set up a cron job to run the Drupal cron once an hour
