require 'spec_helper_acceptance'

describe 'by default' do
  specify 'should provision with no errors' do
    pp = <<-EOS
      file { '/var/cache/packages':
        ensure => directory,
      }

      class { 'drupal':
        package_dir => '/var/cache/packages',
      }

      drupal::core { 'drupal-6.x':
        version        => '6.33',
        archive_md5sum => '33d738678f81a86d9e31ae8af23b45e5',
      }

      drupal::core { 'drupal-7.x':
        version        => '7.31',
        archive_md5sum => 'de256f202930d3ef5ccc6aebc550adaf',
      }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
  end

  describe file('/opt/drupal.org') do
    specify { should be_directory }
  end

  describe file('/opt/drupal.org/drupal-6.33') do
    specify { should be_directory }
  end

  describe file('/opt/drupal.org/drupal-7.31') do
    specify { should be_directory }
  end
end
