helm install stable/prometheus \
    --namespace prometheus \
    --name prometheus

# or upgrade values with
# helm upgrade prometheus \
#      stable/prometheus \
#      -f helm/prometheus.yaml
