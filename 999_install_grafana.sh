helm install stable/grafana \
    --namespace prometheus \
    --name grafana

kubectl get secret --namespace prometheus grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# or upgrade values with
# helm upgrade grafana \
#      stable/grafana \
#      -f helm/grafana.yaml
