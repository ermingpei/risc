helm delete edge-stack -n ambassador
kubectl delete -f https://app.getambassador.io/yaml/edge-stack/3.0.0/aes-crds.yaml
sleep 30
kubectl delete ns ambassador
