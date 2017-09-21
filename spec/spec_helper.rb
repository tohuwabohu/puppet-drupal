require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :root_home => '/root',
    :path      => '/bin:/usr/bin',
  }
end
