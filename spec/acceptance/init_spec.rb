require 'spec_helper_acceptance'

describe 'by default' do
  specify 'should provision with no errors' do
    pp = <<-EOS
      # just a bunch of dependencies
      file { '/var/cache/packages':
        ensure => directory,
      }

      file { '/var/www':
        ensure => directory,
      }

      # test manifest
      class { 'drupal':
        package_dir => '/var/cache/packages',
      }

      drupal::site { 'drupal-6.x':
        core_version => '6.33',
        modules      => {
          'views' => '2.16',
        },
      }

      drupal::site { 'drupal-7.x':
        core_version => '7.32',
        modules      => {
          'views' => '3.8',
        },
      }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe file('/usr/local/bin/composer') do
    specify { should be_file }
    specify { should be_executable }
  end

  describe file('/opt/drupal.org/drush') do
    specify { should be_directory }
  end

  describe file('/usr/local/bin/drush') do
    specify { should be_file }
    specify { should be_executable }
  end

  describe file('/etc/drupal/drupal-6.x.make') do
    specify { should be_file }
  end

  describe file('/etc/drupal/drupal-7.x.make') do
    specify { should be_file }
  end

  describe file('/var/www/drupal-6.x') do
    specify { should be_directory }
  end

  describe file('/var/www/drupal-6.x/modules/system/system.info') do
    its(:content) { should match /version = "6.33"/ }
  end

  describe file('/var/www/drupal-6.x/sites/all/modules/views/views.info') do
    its(:content) { should match /version = "6.x-2.16"/ }
  end

  describe file('/var/www/drupal-7.x') do
    specify { should be_directory }
  end

  describe file('/var/www/drupal-7.x/modules/system/system.info') do
    its(:content) { should match /version = "7.32"/ }
  end

  describe file('/var/www/drupal-7.x/sites/all/modules/views/views.info') do
    its(:content) { should match /version = "7.x-3.8"/ }
  end
end
