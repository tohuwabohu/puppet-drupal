require 'spec_helper'

describe 'drupal::core' do
  let(:title) { 'drupal-7.x' }
  let(:default_version) { '7.31' }
  let(:default_archive) { 'drupal-7.31' }

  describe 'with version' do
    let(:params) { {:version => '7.31'} }

    it { should contain_archive('drupal-7.31') }
  end

  describe 'with version but without archive_md5sum' do
    let(:params) { {:version => default_version} }

    it { should contain_archive(default_archive).with_checksum(false) }
  end

  describe 'with archive_md5sum' do
    let(:params) { {:version => default_version, :archive_md5sum => '123'} }

    it { should contain_archive(default_archive).with_digest_string('123') }
  end
end
