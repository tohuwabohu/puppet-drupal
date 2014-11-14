require 'spec_helper'

describe 'drupal::site' do
  let(:title) { 'dummy' }
  let(:make_file) { '/etc/drush/dummy.make' }
  let(:settings_file) { '/etc/drush/dummy.settings.php' }
  let(:files_dir) { '/var/lib/dummy' }
  let(:document_root) { '/var/www/dummy' }
  let(:drupal_site_dir) { '/opt/drupal.org/dummy-f07cd86e789c50de12f7d1cdb41e6f4156fcc08b' }
  let(:defaults) do
    {
        :core_version => '7.0'
    }
  end

  describe 'by default' do
    let(:params) { defaults }

    specify { should contain_file(make_file) }
    specify { should contain_file(settings_file) }
    specify { should contain_file(document_root) }
    specify { should contain_file(files_dir) }
    specify { should contain_file(files_dir).with_owner('www-data') }
    specify { should contain_file(files_dir).with_group('www-data') }
    specify { should contain_file(files_dir).with_mode('0755') }
    specify { should contain_file("#{drupal_site_dir}/sites/default/files").with_target(files_dir) }
  end

  describe 'with core_version => 6.33' do
    let(:params) { defaults.merge(:core_version => '6.33') }

    specify { should contain_file(make_file).with_ensure('file') }
    specify { should contain_file(make_file).with_content(/core = 6.x/) }
    specify { should contain_file(make_file).with_content(/projects\[drupal\]\[version\] = 6\.33/) }
  end

  describe 'with core_version => 7.32' do
    let(:params) { defaults.merge(:core_version => '7.32') }

    specify { should contain_file(make_file).with_ensure('file') }
    specify { should contain_file(make_file).with_content(/core = 7.x/) }
    specify { should contain_file(make_file).with_content(/projects\[drupal\]\[version\] = 7\.32/) }
  end

  describe 'with empty core_version' do
    let(:params) { defaults.merge(:core_version => '') }

    specify  do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /core_version/)
    end
  end

  describe 'with invalid modules' do
    let(:params) { defaults.merge(:modules => 'should be a hash') }

    specify do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /should be a hash/)
    end
  end

  describe 'with modules view from drupal.org (shorthand notion)' do
    let(:params) { defaults.merge(:modules => { 'views' => '3.8' }) }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[version\] = 3\.8/) }
  end

  describe 'with modules view from drupal.org' do
    let(:params) { defaults.merge(:modules => { 'views' => { 'version' => '3.8'} }) }

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
    let(:params) { defaults.merge(:modules => { 'views' => { 'download' => view_module } }) }

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
    let(:params) { defaults.merge(:modules => { 'views' => { 'download' => view_module } }) }

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
    let(:params) { defaults.merge(:modules => { 'views' => view_module }) }

    specify { should contain_file(make_file).with_content(/projects\[views\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/projects\[views\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with invalid themes' do
    let(:params) { defaults.merge(:themes => 'should be a hash') }

    specify do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /should be a hash/)
    end
  end

  describe 'with theme zen from drupal.org (shorthand notion)' do
    let(:params) { defaults.merge(:themes => { 'zen' => '5.5' }) }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[version\] = 5\.5/) }
  end

  describe 'with theme zen from drupal.org' do
    let(:params) { defaults.merge(:themes => { 'zen' => { 'version' => '5.5' } }) }

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
    let(:params) { defaults.merge(:themes => { 'zen' => { 'download' => zen_theme } }) }

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
    let(:params) { defaults.merge(:themes => { 'zen' => { 'download' => zen_theme } }) }

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
    let(:params) { defaults.merge(:themes => { 'zen' => zen_theme }) }

    specify { should contain_file(make_file).with_content(/projects\[zen\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/projects\[zen\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with invalid libraries' do
    let(:params) { defaults.merge(:libraries => 'should be a hash') }

    specify do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /should be a hash/)
    end
  end

  describe 'with library jquery_ui from drupal.org (shorthand notion)' do
    let(:params) { defaults.merge(:libraries => { 'jquery_ui' => '5.5' }) }

    specify { should contain_file(make_file).with_content(/libraries\[jquery_ui\]\[version\] = 5\.5/) }
  end

  describe 'with library jquery_ui from drupal.org' do
    let(:params) { defaults.merge(:libraries => { 'jquery_ui' => { 'version' => '5.5' } }) }

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
    let(:params) { defaults.merge(:libraries => { 'lib' => { 'download' => some_library } }) }

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
    let(:params) { defaults.merge(:libraries => { 'lib' => { 'download' => some_library } }) }

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
    let(:params) { defaults.merge(:libraries => { 'lib' => some_library }) }

    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[patch\]\[\] = http:\/\/example.com\/first.patch/) }
    specify { should contain_file(make_file).with_content(/libraries\[lib\]\[patch\]\[\] = \/path\/to\/patch/) }
  end

  describe 'with custom destination for a library' do
    let(:some_library) do
      {
        'version'     => '1.0',
        'destination' => 'modules/contrib/project'
      }
    end
    let(:params) { defaults.merge(:libraries => { 'lib' => some_library }) }

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

  describe 'without settings_content' do
    let(:params) { defaults }

    specify { should contain_file(settings_file).with(
        'content' => nil,
        'source'  => '/opt/drupal.org/dummy-f07cd86e789c50de12f7d1cdb41e6f4156fcc08b/sites/default/default.settings.php',
        'replace' => false,
        'owner'   => 'www-data',
        'group'   => 'www-data',
        'mode'    => '0600'
      )
    }
  end

  describe 'with settings_content' do
    let(:settings_content) { 'some content' }
    let(:params) { defaults.merge({:settings_content => settings_content}) }

    specify { should contain_file(settings_file).with(
        'content' => settings_content,
        'source'  => nil,
        'replace' => true,
        'owner'   => 'www-data',
        'group'   => 'www-data',
        'mode'    => '0400'
      )
    }
  end

  describe 'with custom files directory' do
    let(:params) { defaults.merge({:files_target => '/path/to/files'}) }

    specify { should contain_file('/path/to/files') }
    specify { should contain_file("#{drupal_site_dir}/sites/default/files").with_target('/path/to/files') }
  end

  describe 'with invalid process' do
    let(:params) { defaults.merge({:process => '//'}) }

    specify do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /process/)
    end
  end

  describe 'with custom process' do
    let(:params) { defaults.merge({:process => 'dummy'}) }

    specify { should contain_file(settings_file).with_owner('dummy') }
    specify { should contain_file(settings_file).with_group('dummy') }
    specify { should contain_file(files_dir).with_owner('dummy') }
    specify { should contain_file(files_dir).with_group('dummy') }
  end

  describe 'with files_manage => false' do
    let(:params) { defaults.merge({:files_manage => false}) }

    specify { should_not contain_file(files_dir) }
    specify { should contain_file("#{drupal_site_dir}/sites/default/files").with_target(files_dir) }
  end

  describe 'with invalid files_manage' do
    let(:params) { defaults.merge({:files_manage => 'invalid'}) }

    specify do
      expect { should contain_file(make_file) }.to raise_error(Puppet::Error, /is not a boolean/)
    end
  end

  describe 'with custom document_root => /path/to/file' do
    let(:params) { defaults.merge({:document_root => '/path/to/file'}) }

    specify { should contain_file('/path/to/file') }
  end
end
