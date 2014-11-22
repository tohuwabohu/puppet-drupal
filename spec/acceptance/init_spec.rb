require 'spec_helper_acceptance'

describe 'drupal' do
  specify 'should provision with no errors' do
    pp = <<-EOS
      # just a bunch of dependencies
      $required_directories = [
        '/var/cache/puppet',
        '/var/cache/puppet/archives',
        '/var/www',
      ]
      file { $required_directories:
        ensure => directory,
      }
      package { 'curl':
        ensure => installed,
      }
      package { 'php5-cli':
        ensure => installed,
      }

      # test manifest
      class { 'drupal': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe file('/usr/local/bin/composer') do
    specify { should be_file }
    specify { should be_executable }
  end

  describe file('/opt/drupal.org/drush-6.4.0') do
    specify { should be_directory }
  end

  describe file('/usr/local/bin/drush') do
    specify { should be_file }
    specify { should be_executable }
  end
end
