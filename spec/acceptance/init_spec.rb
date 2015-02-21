require 'spec_helper_acceptance'
include TestDependencies

describe 'drupal' do
  specify 'should provision with no errors' do
    apply_manifest(with_test_dependencies("class { 'drupal': }"), :catch_failures => true)
  end

  specify 'should be idempotent' do
    apply_manifest(with_test_dependencies("class { 'drupal': }"), :catch_changes => true)
  end

  describe file('/usr/local/bin/composer') do
    specify { should be_file }
    specify { should be_executable }
  end

  describe file('/opt/drupal.org/drush-6.5.0') do
    specify { should be_directory }
  end

  describe file('/usr/local/bin/drush') do
    specify { should be_file }
    specify { should be_executable }
  end
end
