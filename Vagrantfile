# -*- mode: ruby -*-
# vi: set ft=ruby :

default_box = 'ubuntu-server-12042-x64-vbox4210'

Vagrant.configure("2") do |config|
  config.vm.define :vm1 do |vm1|
    vm1.vm.box       = default_box
    vm1.vm.box_url   = 'http://puppet-vagrant-boxes.puppetlabs.com/' + vm1.vm.box + '.box'
    vm1.vm.hostname  = 'miab'
    vm1.vm.network :public_network, :mac => '08002700dead'
    vm1.vm.provision :puppet do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.module_path    = 'modules'
      puppet.manifest_file  = 'init.pp'
      puppet.options = '--hiera_config hiera.yaml'
    end
  end
end
