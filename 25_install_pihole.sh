#!/bin/bash
if [ -z "$(helm repo list | grep mojo2600)" ]; then
    helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
fi

helm repo update

if [ -z "$(helm list | grep pihole)" ]; then
    
    helm install \
        pihole \
        mojo2600/pihole \
        -f helm/pihole.yaml

else

    helm upgrade \
        pihole \
        mojo2600/pihole \
        -f helm/pihole.yaml

fi