
kubectl apply -f kestro/kestro-media.yaml

if [ -z "$(kubectl -n kestro-media get secrets tls-media)" ]; then
        kubectl -n kestro-media create secret generic tls-media \
                --from-file=tls.crt=/home/jan/git/janvolck/ca/servers/certs/media.cert.chain.pem \
                --from-file=tls.key=/home/jan/git/janvolck/ca/servers/private/media.key.pem
fi

kubectl apply -f kestro/emby.yaml