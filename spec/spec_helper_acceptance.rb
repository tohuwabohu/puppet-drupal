require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_module_on(hosts)
install_module_from_forge_on(hosts, 'puppetlabs-stdlib', '= 4.15.0')
install_module_from_forge_on(hosts, 'camptocamp-archive', '= 0.9.0')
