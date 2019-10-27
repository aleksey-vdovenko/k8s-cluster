# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", path: "docker/docker-setup.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 1
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
    end
    
    kmaster.vm.hostname = "kube-master"
    kmaster.vm.network "private_network", type: "dhcp"
    kmaster.vm.network "forwarded_port", guest: 6443, host: 6443

    kmaster.vm.provision "shell", path: "kubernetes/kubernetes-master-setup.sh"
  end

  config.vm.define "knode1" do |knode1|
    knode1.vm.hostname = "kube-node-1"
    knode1.vm.network "private_network", type: "dhcp"

    knode1.vm.provision "shell", path: "kubernetes/kubernetes-node-setup.sh"
  end

  config.vm.define "knode2" do |knode2|
    knode2.vm.hostname = "kube-node-2"
    knode2.vm.network "private_network", type: "dhcp"

    knode2.vm.provision "shell", path: "kubernetes/kubernetes-node-setup.sh"
  end

end
