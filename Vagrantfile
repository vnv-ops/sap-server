# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

settings = YAML.load_file File.dirname(File.expand_path(__FILE__)) + '/config.yml'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/opensuse-leap-42.3"
  config.disksize.size = settings['disksize']

  config.vm.provider "virtualbox" do |vb|
    vb.name = settings['name']
    vb.cpus = settings['cpus']
    vb.memory = settings['memory']
  end

  config.vm.provision "initial-setup",
    type: "shell",
    args: settings['ip-address'],
    path: "./provision/initial-setup.sh"

  config.vm.provision :reload

  config.vm.provision "filesystem",
    type: "shell",
    path: "./provision/filesystem.sh"

  config.vm.provision :reload

  config.vm.provision "btrfs",
    type: "shell",
    path: "./provision/btrfs.sh"

  config.vm.provision :reload

  config.vm.provision "sap",
    type: "shell",
    args: settings['sap_password'],
    path: "./provision/sap-install.sh"

  config.vm.provision :reload

  config.vm.provision "sap-config",
    type: "shell",
    path: "./provision/sap-config.sh"

  config.vm.provision :reload

  config.vm.network "private_network", ip: settings['ip-address']

  config.vm.synced_folder ".", "/vagrant", type:"rsync",
    rsync__exclude: ["Vagrantfile", "sap_install", "*.yml", "docs", "*.md"],
    rsync__chown: false

  config.vm.synced_folder "./sap_install", "/sap_install", create: true
end
