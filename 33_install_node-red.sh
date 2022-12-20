kubectl apply -f kestro/node-red.yaml

if kubectl -n kestro-media get secret tls-node-red > /dev/null 2>&1; then
        kubectl -n kestro-media delete secret tls-node-red
fi

kubectl -n kestro-media create secret generic tls-node-red \
        --from-file=tls.crt=/datapool/development/ca/servers/certs/node-red.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/servers/private/node-red.key.pem