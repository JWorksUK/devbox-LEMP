# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "local-dev"
  config.vm.network "private_network", ip: "10.10.10.10"
  config.vm.synced_folder "./site", "/var/www/site", :nfs => true
  config.vm.provision 'shell', path: './devops/scripts/provision.sh'
  config.vm.provision 'shell', path: './devops/scripts/mysql_secure_installation.sh'
  config.vm.provision 'shell', path: './devops/scripts/devserver.sh'
end
