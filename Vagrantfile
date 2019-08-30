# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
    vb.cpus = 2
  end
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", inline: <<-SHELL
  sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  sudo systemctl restart sshd
  SHELL


  config.vm.define "dev1" do |dev1|
    dev1.vm.box = "generic/centos7"
    dev1.vm.hostname = "dev1"
    dev1.vm.network "private_network", ip: "100.64.11.11"
  end

  config.vm.define "dev2" do |dev2|
    dev2.vm.box = "generic/centos7"
    dev2.vm.hostname = "dev2"
    dev2.vm.network "private_network", ip: "100.64.11.12"
  end

  config.vm.define "dev3" do |dev3|
    dev3.vm.box = "generic/centos7"
    dev3.vm.hostname = "dev3"
    dev3.vm.network "private_network", ip: "100.64.11.13"
  end

  config.vm.define "dev4" do |dev4|
    dev4.vm.box = "generic/centos7"
    dev4.vm.hostname = "dev4"
    dev4.vm.network "private_network", ip: "100.64.11.14"

    dev4.vm.provider "virtualbox" do |vb|
       disk='./dev4-disk.vdi'
       unless File.exist?(disk)
         vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 40 * 1024]
       end
       vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
  end

  config.vm.define "dev5" do |dev5|
    dev5.vm.box = "generic/centos7"
    dev5.vm.hostname = "dev5"
    dev5.vm.network "private_network", ip: "100.64.11.15"

    dev5.vm.provider "virtualbox" do |vb|
       disk='./dev5-disk.vdi'
       unless File.exist?(disk)
         vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 40 * 1024]
       end
       vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
  end

  config.vm.define "dev6" do |dev6|
    dev6.vm.box = "generic/centos7"
    dev6.vm.hostname = "dev6"
    dev6.vm.network "private_network", ip: "100.64.11.16"

    dev6.vm.provider "virtualbox" do |vb|
       disk='./dev6-disk.vdi'
       unless File.exist?(disk)
         vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 40 * 1024]
       end
       vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk]
    end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
