#!/bin/bash

# Update apt package index
sudo apt update

# Install Docker
sudo apt install -y docker.io

# Install Kubernetes components
sudo apt install -y apt-transport-https ca-certificates curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl

# Disable swap
sudo swapoff -a

# Initialize Kubernetes cluster
sudo kubeadm init

# Set up Kubernetes configuration for current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy pod network (optional but recommended)
kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml

# Print instructions for joining worker nodes
echo "Kubernetes cluster initialized. Please follow the instructions provided above to join worker nodes."

