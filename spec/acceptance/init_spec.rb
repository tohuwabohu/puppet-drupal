require 'spec_helper_acceptance'

describe 'drupal' do
  manifest = <<-EOS
    file { '/var/www':
      ensure => directory,
    }

    class { 'drupal': }
  EOS

  specify 'should provision with no errors' do
    apply_manifest(manifest, :catch_failures => true)
  end

  specify 'should be idempotent' do
    apply_manifest(manifest, :catch_changes => true)
  end

  describe file('/opt/drupal.org/drush') do
    specify { should be_directory }
  end

  describe file('/usr/local/bin/drush') do
    specify { should be_file }
    specify { should be_executable }
    specify { should be be_linked_to /\/opt\/drupal.org\/drush\/drush-[\d\\.]+\.phar/ }
  end

  describe command('drush --version') do
    its(:exit_status) { should eq 0 }
  end
end
