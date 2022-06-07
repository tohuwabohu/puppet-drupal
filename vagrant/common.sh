#!/bin/sh
export PATH=$PATH:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin

wget https://raw.githubusercontent.com/Puppet-Finland/scripts/master/bootstrap/linux/install-puppet.sh -q -O /vagrant/vagrant/install-puppet.sh
/bin/sh /vagrant/vagrant/install-puppet.sh -n drupal -p 7

wget https://raw.githubusercontent.com/Puppet-Finland/scripts/master/bootstrap/linux/install-puppet-modules.sh -q -O /vagrant/vagrant/install-puppet-modules.sh
/bin/sh /vagrant/vagrant/install-puppet-modules.sh -n drupal
