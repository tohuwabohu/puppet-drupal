require 'spec_helper'

describe 'drupal' do
  let(:title) { 'drupal' }
  let(:drush_version) { '8.4.12' }
  let(:drush_path) { "/opt/drupal.org/drush/drush-#{drush_version}.phar" }

  describe 'by default' do
    let(:params) { {} }

    specify { should contain_file('/opt/drupal.org').with_ensure('directory') }
    specify { should contain_file('/etc/drush').with_ensure('directory') }
    specify { should contain_file('/var/log/drush').with_ensure('directory') }
    specify { should contain_file('/usr/local/sbin/drupal-update.sh').with_ensure('file') }
    specify { should contain_archive(drush_path) }
    specify { should contain_archive(drush_path).with_source(/#{drush_version}\/drush\.phar/) }
    specify { should contain_archive(drush_path).with_checksum_type('sha256') }
  end

  describe 'with install_dir => /path/to/dir' do
    let(:params) { {:install_dir => '/path/to/dir'} }

    specify { should contain_file('/path/to/dir').with_ensure('directory') }
  end

  describe 'with config_dir => /path/to/dir' do
    let(:params) { {:config_dir => '/path/to/dir'} }

    specify { should contain_file('/path/to/dir').with_ensure('directory') }
  end

  describe 'with drush_version => 7.0.0' do
    let(:params) { {:drush_version => '7.0.0'} }

    specify { should contain_archive('/opt/drupal.org/drush/drush-7.0.0.phar').with_source(/7\.0\.0\/drush\.phar/) }
  end

  describe 'with drush_archive_checksum => beef' do
    let(:params) { {:drush_archive_checksum => 'beef'} }

    specify { should contain_archive(drush_path).with_checksum('beef') }
  end

  describe 'with drush_archive_checksum_type => md5' do
    let(:params) { {:drush_archive_checksum_type => 'md5'} }

    specify { should contain_archive(drush_path).with_checksum_type('md5') }
  end
end
