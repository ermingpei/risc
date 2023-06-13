kubectl apply -f https://app.getambassador.io/yaml/v2-docs/3.5.1/quickstart/qotm.yaml
kubectl apply -f - <<EOF
---
apiVersion: getambassador.io/v3alpha1
kind: Mapping
metadata:
  name: quote-backend
spec:
  hostname: "*"
  prefix: /
  service: quote
  docs:
    path: "/.ambassador-internal/openapi-docs"
EOF

export LB_ENDPOINT=$(kubectl -n ambassador get svc  edge-stack \
  -o "go-template={{range .status.loadBalancer.ingress}}{{or .ip .hostname}}{{end}}")

curl -Lki https://$LB_ENDPOINT/


