require 'spec_helper'

describe 'drupal' do
  let(:title) { 'drupal' }

  describe 'by default' do
    let(:params) { {} }

    specify { should contain_file('/opt/drupal.org').with_ensure('directory') }
    specify { should contain_file('/etc/drush').with_ensure('directory') }
    specify { should contain_file('/var/log/drush').with_ensure('directory') }
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
end
