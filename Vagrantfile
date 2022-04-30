# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_lxd = <<-LXD
sudo apt-get update -y
snap install lxd
newgrp lxd
LXD

Vagrant.configure("2") do |config|

	if Vagrant.has_plugin? "vagrant-vbguest"
		config.vbguest.no_install = true
		config.vbguest.auto_update = false
		config.vbguest.no_remote = true
	end
	
	config.vm.define :balancer do |balancer|
		balancer.vm.box = "bento/ubuntu-20.04"
		balancer.vm.network :private_network, ip: "192.168.70.2"
		balancer.vm.hostname = "balancer"
		balancer.vm.provision "file", source: "cluster.yml", destination: "/tmp/cluster.yml"
		balancer.vm.provision :shell, inline: "mv /tmp/cluster.yml /home/vagrant/cluster.yml"
		balancer.vm.provision :shell, inline: $install_lxd
		balancer.vm.provision :shell, path: "provisioning_bal.sh"
		balancer.vm.synced_folder "./shared_folder", "/home/vagrant/shared_folder"
	end
	
	config.vm.define :web1 do |web1|
		web1.vm.box = "bento/ubuntu-20.04"
		web1.vm.network :private_network, ip: "192.168.70.3"
		web1.vm.hostname = "web1"
		web1.vm.provision :shell, inline: $install_lxd
		web1.vm.provision :shell, path: "provisioning_web1.sh"
	end
	
	config.vm.define :web2 do |web2|
		web2.vm.box = "bento/ubuntu-20.04"
		web2.vm.network :private_network, ip: "192.168.70.4"
		web2.vm.hostname = "web2"
		web2.vm.provision :shell, inline: $install_lxd
		web2.vm.provision :shell, path: "provisioning_web2.sh"
	end

	config.vm.define :web3 do |web3|
		web3.vm.box = "bento/ubuntu-20.04"
		web3.vm.network :private_network, ip: "192.168.70.5"
		web3.vm.hostname = "web3"
		web3.vm.provision :shell, inline: $install_lxd
		web3.vm.provision :shell, path: "provisioning_web3.sh"
	end

	config.vm.define :web4 do |web4|
		web4.vm.box = "bento/ubuntu-20.04"
		web4.vm.network :private_network, ip: "192.168.70.6"
		web4.vm.hostname = "web4"
		web4.vm.provision :shell, inline: $install_lxd
		web4.vm.provision :shell, path: "provisioning_web4.sh"
	end
end