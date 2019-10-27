#!/bin/bash

apt-get update
apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main  
EOF

apt-get update
apt-get install -y kubeadm kubectl kubelet kubernetes-cni

# Initializing kubernetes master
kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --apiserver-advertise-address=172.28.128.10

# Allowing vagrant user to manage the cluster
mkdir -p /home/vagrant/.kube && chown vagrant:vagrant /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config && chown vagrant:vagrant /home/vagrant/.kube/config
echo "export KUBECONFIG=/home/vagrant/.kube/config" | tee -a /home/vagrant/.bashrc

# Allowing root user to manage the cluster
mkdir ~/.kube && cp -i /etc/kubernetes/admin.conf ~/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubeadm token create --print-join-command > /vagrant/join-command
