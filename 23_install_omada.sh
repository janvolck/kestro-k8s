kubectl apply -f kestro/kestro-network.yaml

if kubectl -n kestro get secret tls-omada-web > /dev/null 2>&1; then
        kubectl -n kestro delete secret tls-omada-web
fi

kubectl -n kestro create secret generic tls-omada-web \
        --from-file=tls.crt=/datapool/development/ca/servers/certs/omada.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/servers/private/omada.key.pem


kubectl apply -f kestro/tplink-omada-controller5.yaml

