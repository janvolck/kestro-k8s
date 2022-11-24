#!/bin/bash

if kubectl -n kubernetes-dashboard get secret tls-k8s-dashboard > /dev/null 2>&1; then
        kubectl -n kubernetes-dashboard delete secret tls-k8s-dashboard
fi

kubectl -n kubernetes-dashboard create secret generic tls-k8s-dashboard \
        --from-file=tls.crt=/datapool/development/ca/servers/certs/k8s.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/servers/private/k8s.key.pem

kubectl apply -f configs/k8s-dashboard.yaml 
