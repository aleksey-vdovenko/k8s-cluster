#!/bin/bash

apt-get update
apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main  
EOF

apt-get update
apt-get install -y kubeadm kubectl kubelet kubernetes-cni

# kubeadm init \
#   --pod-network-cidr=10.244.0.0/16 \
#   --apiserver-advertise-address=172.28.128.3

# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# echo "export KUBECONFIG=$HOME/admin.conf" | tee -a ~/.bashrc

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
