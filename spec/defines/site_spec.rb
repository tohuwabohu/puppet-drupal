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

  describe 'with modules view from drupal.org (shorthand notion)' do
    let(:params) { {:core_version => '7.0', :modules => { 'views' => '3.8' } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[version\] = 3\.8/) }
  end

  describe 'with modules view from drupal.org' do
    let(:params) { {:core_version => '7.0', :modules => { 'views' => { 'version' => '3.8'} } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[version\] = 3\.8/) }
  end

  describe 'with modules view from custom location' do
    let(:view_module) do
      {
        'type' => 'file',
        'url'  => 'http://example.com/file.zip',
        'md5'  => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :modules => { 'views' => view_module } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[type\] = module/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[type\] = file/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[url\] = http:\/\/example.com\/file.zip/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[md5\] = beef/) }
  end

  describe 'with modules view from git repository' do
    let(:view_module) do
      {
        'type'     => 'git',
        'url'      => 'http://git.drupal.org/project/drupal.git',
        'revision' => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :modules => { 'views' => view_module } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[type\] = module/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[type\] = git/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[url\] = http:\/\/git.drupal.org\/project\/drupal.git/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[download\]\[revision\] = beef/) }
  end

  describe 'with patches for a module' do
    let(:view_module) do
      {
        'version' => '1.0',
        'patch'   => [
          'http://example.com/first.patch',
          '/path/to/patch'
        ]
      }
    end
    let(:params) { {:core_version => '7.0', :modules => { 'views' => view_module } } }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with theme zen from drupal.org (shorthand notion)' do
    let(:params) { {:core_version => '7.0', :themes => { 'zen' => '5.5' } } }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[version\] = 5\.5/) }
  end

  describe 'with theme zen from drupal.org' do
    let(:params) { {:core_version => '7.0', :themes => { 'zen' => { 'version' => '5.5' } } } }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[version\] = 5\.5/) }
  end

  describe 'with theme zen from custom location' do
    let(:zen_theme) do
      {
        'type' => 'file',
        'url'  => 'http://example.com/file.zip',
        'md5'  => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :themes => { 'zen' => zen_theme } } }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[type\] = theme/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[type\] = file/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[url\] = http:\/\/example.com\/file.zip/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[md5\] = beef/) }
  end

  describe 'with theme zen from git repository' do
    let(:zen_theme) do
      {
        'type'     => 'git',
        'url'      => 'http://git.drupal.org/project/drupal.git',
        'revision' => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :themes => { 'zen' => zen_theme } } }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[type\] = theme/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[type\] = git/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[url\] = http:\/\/git.drupal.org\/project\/drupal.git/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[download\]\[revision\] = beef/) }
  end

  describe 'with patches for a theme' do
    let(:zen_theme) do
      {
        'version' => '1.0',
        'patch'   => [
          'http://example.com/first.patch',
          '/path/to/patch'
        ]
      }
    end
    let(:params) { {:core_version => '7.0', :themes => { 'zen' => zen_theme } } }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with library jquery_ui from drupal.org (shorthand notion)' do
    let(:params) { {:core_version => '7.0', :libraries => { 'jquery_ui' => '5.5' } } }

    specify { should contain_file(make_file).with_content(/libraries\[jquery_ui\]\[version\] = 5\.5/) }
  end

  describe 'with library jquery_ui from drupal.org' do
    let(:params) { {:core_version => '7.0', :libraries => { 'jquery_ui' => { 'version' => '5.5' } } } }

    specify { should contain_file(make_file).with_content(/libraries\[jquery_ui\]\[version\] = 5\.5/) }
  end

  describe 'with a library from a custom location' do
    let(:some_library) do
      {
        'type' => 'file',
        'url'  => 'http://example.com/file.zip',
        'md5'  => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :libraries => { 'lib' => some_library } } }

    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[type\] = file/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[url\] = http:\/\/example.com\/file.zip/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[md5\] = beef/) }
  end

  describe 'with a library from a git repository' do
    let(:some_library) do
      {
        'type'     => 'git',
        'url'      => 'http://git.drupal.org/project/drupal.git',
        'revision' => 'beef'
      }
    end
    let(:params) { {:core_version => '7.0', :libraries => { 'lib' => some_library } } }

    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[type\] = git/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[url\] = http:\/\/git.drupal.org\/project\/drupal.git/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[download\]\[revision\] = beef/) }
  end

  describe 'with patches for a library' do
    let(:some_library) do
      {
        'version' => '1.0',
        'patch'   => [
          'http://example.com/first.patch',
          '/path/to/patch'
        ]
      }
    end
    let(:params) { {:core_version => '7.0', :libraries => { 'lib' => some_library } } }

    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with custom destination for a library' do
    let(:some_library) do
      {
        'type'        => 'file',
        'url'         => 'http://example.com/file.zip',
        'md5'         => 'beef',
        'destination' => 'modules/contrib/project'
      }
    end
    let(:params) { {:core_version => '7.0', :libraries => { 'lib' => some_library } } }

    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[destination\] = modules\/contrib\/project/) }
  end

  describe 'with custom makefile' do
    let(:custom_makefile) do
      "core = 7.x
       api = 2
       projects[] = drupal"
    end
    let(:params) { {:makefile_content => custom_makefile } }

    specify { should contain_file(make_file).with_content(custom_makefile) }
  end
end
