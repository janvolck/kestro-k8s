#!/bin/bash

if kubectl -n kube-system get secret tls-k8s-dashboard > /dev/null 2>&1; then
        kubectl -n kube-system delete secret tls-k8s-dashboard
fi

kubectl -n kube-system create secret generic tls-k8s-dashboard \
        --from-file=tls.crt=/home/jan/git/janvolck/ca/servers/certs/k8s.cert.chain.pem \
        --from-file=tls.key=/home/jan/git/janvolck/ca/servers/private/k8s.key.pem

kubectl apply -f configs/k3s-dashboard.yaml
