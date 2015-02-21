require 'spec_helper'

describe 'drupal' do
  let(:title) { 'drupal' }

  describe 'by default' do
    let(:params) { {} }

    specify { should contain_file('/opt/drupal.org').with_ensure('directory') }
    specify { should contain_file('/etc/drush').with_ensure('directory') }
    specify { should contain_file('/var/log/drush').with_ensure('directory') }
    specify { should contain_file('/usr/local/sbin/drupal-update.sh').with_ensure('file') }
    specify { should contain_archive('drush-6.5.0') }
  end

  describe 'with install_dir => /path/to/dir' do
    let(:params) { {:install_dir => '/path/to/dir'} }

    specify { should contain_file('/path/to/dir').with_ensure('directory') }
  end

  describe 'with config_dir => /path/to/dir' do
    let(:params) { {:config_dir => '/path/to/dir'} }

    specify { should contain_file('/path/to/dir').with_ensure('directory') }
  end

  describe 'with log_dir => /path/to/dir' do
    let(:params) { {:log_dir => '/path/to/dir'} }

    specify { should contain_file('/path/to/dir').with_ensure('directory') }
  end

  describe 'with drush_version => 7.0.0' do
    let(:params) { {:drush_version => '7.0.0'} }

    specify { should contain_archive('drush-7.0.0') }
  end

  describe 'with drush_archive_md5sum => beef' do
    let(:params) { {:drush_archive_md5sum => 'beef'} }

    specify { should contain_archive('drush-6.5.0').with_digest_string('beef') }
  end
end
