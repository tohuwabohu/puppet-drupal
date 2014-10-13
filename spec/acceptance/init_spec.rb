require 'spec_helper_acceptance'

describe 'by default' do
  specify 'should provision with no errors' do
    pp = <<-EOS
      class { 'drupal': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
  end

  describe file('/opt/drupal.org') do
    specify { should be_directory }
  end
end
