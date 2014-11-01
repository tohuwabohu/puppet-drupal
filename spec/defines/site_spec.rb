require 'spec_helper'

describe 'drupal::site' do
  let(:title) { 'dummy' }
  let(:make_file) { '/etc/drupal/dummy.make' }

  describe 'with core_version => 6.33' do
    let(:params) { {:core_version => '6.33'} }

    specify { should contain_file(make_file).with_ensure('file') }
    specify { should contain_file(make_file).with_content(/core = 6.x/) }
    specify { should contain_file(make_file).with_content(/projects\[drupal\]\[version\] = 6\.33/) }
  end

  describe 'with core_version => 7.32' do
    let(:params) { {:core_version => '7.32'} }

    specify { should contain_file(make_file).with_ensure('file') }
    specify { should contain_file(make_file).with_content(/core = 7.x/) }
    specify { should contain_file(make_file).with_content(/projects\[drupal\]\[version\] = 7\.32/) }
  end

  describe 'with modules view' do
    let(:params) { {:core_version => '7.0', :modules => { 'views' => '3.8' } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[version\] = 3\.8/) }
  end
end
