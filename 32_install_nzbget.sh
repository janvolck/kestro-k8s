#!/bin/bash
kubectl apply -f configs/nzbget.yaml

kubectl -n nzbget create secret generic tls-nzbget-ui \
        --from-file=tls.crt=/datapool/development/ca/intermediate/certs/nzbget.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/intermediate/private/nzbget.key.pem

if [ -z "$(helm repo list | grep k8s-at-home)" ]; then
    helm repo add k8s-at-home https://k8s-at-home.com/charts/
fi

if [ -z "$(helm list -n nzbget | grep nzbget)" ]; then
    helm install nzbget k8s-at-home/nzbget \
        -n nzbget \
        -f helm/nzbget.yaml
else
    helm upgrade \
        -n nzbget \
        -f helm/nzbget.yaml \
        nzbget k8s-at-home/nzbget
fi
