#!/bin/bash
kubectl apply -f kestro/pihole-dns1.yaml 

if [ -z "$(helm repo list | grep mojo2600)" ]; then
    helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
fi

helm repo update

if [ -z "$(helm list -n pihole | grep kestro-dns1)" ]; then
    
    helm install kestro-dns1 \
        mojo2600/pihole \
        -n pihole \
        --create-namespace \
        -f helm/pihole-dns1.yaml

else

    helm upgrade kestro-dns1 \
        mojo2600/pihole \
        -n pihole \
        -f helm/pihole-dns1.yaml

fi