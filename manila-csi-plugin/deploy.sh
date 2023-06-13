#kubectl apply -f manila-csi-config.yaml 
kubectl apply -f manila-csi-secrets.yaml
kubectl apply -f manila-csidriver.yaml
kubectl apply -f manila-csi-controllerplugin-rbac.yaml
kubectl apply -f manila-csi-nodeplugin-rbac.yaml
kubectl apply -f manila-csi-controllerplugin.yaml
sleep 30
kubectl apply -f manila-csi-nodeplugin.yaml
sleep 15
kubectl apply -f sc.yaml
