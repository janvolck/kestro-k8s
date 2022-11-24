kubectl apply -f configs/docker-registry.yaml

helm repo update

helm install stable/docker-registry \
    --namespace docker \
    --name docker-registry \
    -f helm/docker-registry.yaml

# or upgrade values with
# helm upgrade docker-registry \
#      stable/docker-registry \
#      -f helm/docker-registry.yaml 

