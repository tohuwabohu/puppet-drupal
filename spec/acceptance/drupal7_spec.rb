require 'spec_helper_acceptance'

describe 'drupal-7.x' do
  pp = <<-EOS
    # test manifest          
    file { '/var/www':
      ensure => directory,
    }

    class { 'drupal': }

    drupal::site { 'drupal-7.x':
      core_version => '7.56',
      modules      => {
        'ctools'   => {
          'download' => {
            'type'     => 'git',
            'url'      => 'https://git.drupalcode.org/project/ctools.git',
            'revision' => '5438b40dbe532af6a7eca891c86eaef845bff945',
          },
        },
        'pathauto' => {
          'version' => '1.2',
          'patch'   => [
            'https://www.drupal.org/files/pathauto_admin.patch'
          ],
        },
        'views'    => '3.8',
      },
      themes       => {
        'omega' => '4.3',
        'zen'   => {
          'download' => {
            'type' => 'file',
            'url'  => 'http://ftp.drupal.org/files/projects/zen-7.x-5.5.tar.gz',
            'md5'  => '9ca3c99dedec9bfb1cc73b360990dad9',
          },
        },
      },
      libraries    => {
        'jquery_cycle' => {
          'download' => {
            'type' => 'file',
            'url'  => 'https://github.com/malsup/cycle/archive/3.0.3.zip',
            'md5'  => '21cccf32fbec6bf8fb3a32e9acbf9b20',
          },
        },
      },
    }
  EOS

  specify 'should provision with no errors' do
    apply_manifest(pp, :catch_failures => true)
  end

  specify 'should be idempotent' do
    apply_manifest(pp, :catch_changes => true)
  end

  describe file('/etc/drush/drupal-7.x.make') do
    specify { should be_file }
  end

  describe file('/var/www/drupal-7.x') do
    specify { should be_directory }
  end

  describe file('/var/www/drupal-7.x/modules/system/system.info') do
    its(:content) { should match /version = "7.56"/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/modules/ctools/ctools.info') do
    its(:content) { should match /name = Chaos tools/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/modules/ctools/.git') do
    specify { should_not be_directory }
  end

  describe file('/var/www/drupal-7.x/sites/all/modules/pathauto/pathauto.admin.inc') do
    its(:content) { should match /module_implements\('pathauto', false, true\);/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/modules/views/views.info') do
    its(:content) { should match /version = "7.x-3.8"/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/themes/omega/omega/omega.info') do
    its(:content) { should match /version = "7.x-4.3"/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/themes/zen/zen.info') do
    its(:content) { should match /version = "7.x-5.5"/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/libraries/jquery_cycle/jquery.cycle.lite.js') do
    specify { should be_file }
  end
end
