kubectl delete -f sc.yaml
kubectl delete -f manila-csi-nodeplugin.yaml
kubectl delete -f manila-csi-controllerplugin.yaml
kubectl delete -f manila-csi-secrets.yaml
kubectl delete -f manila-csidriver.yaml
#kubectl delete -f manila-csi-config.yaml
kubectl delete -f manila-csi-controllerplugin-rbac.yaml
kubectl delete -f manila-csi-nodeplugin-rbac.yaml
