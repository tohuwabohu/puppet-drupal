require 'spec_helper_acceptance'

describe 'a broken module' do
  specify 'should fail the puppet run' do
    pp = <<-EOS
      # just a bunch of dependencies
      $required_directories = [
        '/var/cache/puppet',
        '/var/cache/puppet/archives',
      ]
      file { $required_directories:
        ensure => directory,
      }

      # test manifest
      class { 'drupal': }

      drupal::site { 'broken':
        core_version => '7.32',
        modules      => {
          'nonexistant' => '1.0',
        },
      }
    EOS

    apply_manifest(pp, :acceptable_exit_codes => [91])
  end
end
