require 'spec_helper_acceptance'
include TestDependencies

describe 'drupal' do
  specify 'should provision with no errors' do
    pp = <<-EOS
      # test manifest
      class { 'drupal': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(with_test_dependencies(pp), :catch_failures => true)
    apply_manifest(with_test_dependencies(pp), :catch_changes => true)
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
