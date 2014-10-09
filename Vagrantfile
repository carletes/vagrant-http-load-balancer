# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http =     ENV.fetch("http_proxy",  ENV.fetch("HTTP_PROXY", nil))
    config.proxy.https =    ENV.fetch("https_proxy", ENV.fetch("HTTPS_PROXY", nil))
    config.proxy.ftp =      ENV.fetch("ftp_proxy",   ENV.fetch("FTP_PROXY", nil))
    config.proxy.no_proxy = ENV.fetch("no_proxy",    ENV.fetch("NO_PROXY", nil))
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--bioslogofadein", "off",
      "--bioslogofadeout", "off",
      "--bioslogodisplaytime", "0",
      "--biosbootmenu", "disabled",
    ]
  end

  config.vm.define "lb" do |n|
    n.vm.hostname = "lb"
    n.vm.box = "carletes/openbsd-5.5"
    n.vm.guest=:openbsd
    n.vm.synced_folder ".", "/vagrant", type: :rsync

    n.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
	"--cpus",   "1",
	"--memory", "256",
      ]
    end

    n.vm.network "forwarded_port", guest: 8080, host: 8080

    n.vm.network "private_network",
                 :ip => "192.168.0.10",
		 :netmask => "255.255.255.0"

    n.vm.provision "shell", path: "provision/provision-lb.sh"
  end

  config.vm.define "www1" do |n|
    n.vm.hostname = "www1"
    n.vm.box = "hashicorp/precise64"

    n.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
	"--cpus",   "1",
	"--memory", "384",
      ]
    end

    n.vm.network "private_network",
                 :ip => "192.168.0.20",
		 :netmask => "255.255.255.0"

    n.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "provision/puppet"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "provision/puppet/modules"
    end
  end

  config.vm.define "www2" do |n|
    n.vm.hostname = "www2"
    n.vm.box = "hashicorp/precise64"

    n.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
	"--cpus",   "1",
	"--memory", "384",
      ]
    end

    n.vm.network "private_network",
                 :ip => "192.168.0.30",
		 :netmask => "255.255.255.0"

    n.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "provision/puppet"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "provision/puppet/modules"
    end
  end
end
