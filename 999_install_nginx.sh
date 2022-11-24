helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

helm install nginx-ingress nginx-stable/nginx-ingress \
    -f helm/nginx.yaml

# or upgrade values with
# helm upgrade nginx-ingress \
#      stable/nginx-ingress \
#      -f helm/nginx.yaml
