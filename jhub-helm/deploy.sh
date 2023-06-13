helm upgrade --cleanup-on-fail --install jhub200 jupyterhub/jupyterhub --namespace jhub --create-namespace --version=2.0.0 --values values.yaml
