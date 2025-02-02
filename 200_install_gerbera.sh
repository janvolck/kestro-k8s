
kubectl apply -f kestro/kestro-media.yaml

if [ -z "$(kubectl -n kestro-media get secrets tls-media)" ]; then
        kubectl -n kestro-media create secret generic tls-media \
                --from-file=tls.crt=/datapool/development/ca/servers/certs/media.cert.chain.pem \
                --from-file=tls.key=/datapool/development/ca/servers/private/media.key.pem
fi

kubectl apply -f kestro/gerbera.yaml