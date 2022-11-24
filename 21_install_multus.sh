#!/bin/bash

# install git in order to download multus sources
if [ -z "$(which git)" ]; then
  sudo apt install git
fi

# clone multus directory
if [ ! -e multus ]; then
  mkdir multus
  cd multus

  git clone https://github.com/intel/multus-cni.git
fi

if [ -e multus-cni ]; then
  cd multus-cni
  git checkout refs/tags/v3.4 
  git status

## NOTE custom armv7l image must be loaded from janvolck/multus-cni:latest-armv7
  cat ./images/multus-daemonset.yml | kubectl apply -f -

  cd ..
fi

kubectl get pods --all-namespaces | grep -i multus
