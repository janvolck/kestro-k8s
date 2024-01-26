# kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.10/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

if [ -z "$(helm repo list | grep traefik)" ]; then
   
    helm repo add traefik https://helm.traefik.io/traefik
    
fi

helm repo update

if [ -z "$(helm list | grep traefik)" ]; then
    
    helm install \
        traefik \
        traefik/traefik \
        -f helm/traefik.yaml

else

    helm upgrade \
        traefik \
        traefik/traefik \
        -f helm/traefik.yaml

fi

if kubectl get secret tls-traefik-dashboard > /dev/null 2>&1; then
        kubectl delete secret tls-traefik-dashboard
fi

kubectl create secret generic tls-traefik-dashboard \
        --from-file=tls.crt=/datapool/development/ca/servers/certs/traefik.cert.chain.pem \
        --from-file=tls.key=/datapool/development/ca/servers/private/traefik.key.pem

kubectl apply -f configs/traefik-dashboard.yaml

