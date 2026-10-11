kubectl apply -f kestro/node-red.yaml

kubectl -n kestro-nodered create secret generic tls-node-red \
        --from-file=tls.crt=/home/jan/git/janvolck/ca/servers/certs/node-red.cert.chain.pem \
        --from-file=tls.key=/home/jan/git/janvolck/ca/servers/private/node-red.key.pem \
        --dry-run=client -o yaml | kubectl apply -f -