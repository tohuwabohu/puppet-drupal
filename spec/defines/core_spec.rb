require 'spec_helper'

describe 'drupal::core' do
  let(:title) { 'drupal-7.x' }
  let(:default_version) { '7.31' }
  let(:default_archive) { 'drupal-7.31' }

  describe 'with version' do
    let(:params) { {:version => '7.31'} }

    it { should contain_exec('install-drupal-7.31') }
  end
end
