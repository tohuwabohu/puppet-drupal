require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_PROVISION'] == 'no'
  hosts.each do |host|
    install_puppet
    install_package host, 'curl'
    install_package host, 'php5-cli'
  end
end

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      # Install module
      copy_module_to(host, :source => proj_root, :module_name => 'drupal')

      # Install dependencies
      on host, puppet('module', 'install', 'gini-archive', '--version 0.2.0'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-stdlib', '--version 4.3.2'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
