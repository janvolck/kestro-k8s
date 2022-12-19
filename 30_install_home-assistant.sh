kubectl apply -f kestro/home-assistant.yaml

if kubectl -n home-assistant get secret tls-home-assistant > /dev/null 2>&1; then
        kubectl -n home-assistant delete secret tls-home-assistant
fi

kubectl -n home-assistant create secret generic tls-home-assistant \
        --from-file=tls.crt=/datapool/development/ca/servers/certs/home-assistant.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/servers/private/home-assistant.key.pem