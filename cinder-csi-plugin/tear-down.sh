kubectl delete -f cinder-csi-nodeplugin.yaml
kubectl delete -f cinder-csi-controllerplugin.yaml
kubectl delete -f cinder-csi-driver.yaml
kubectl delete -f cinder-csi-nodeplugin-rbac.yaml
kubectl delete -f cinder-csi-controllerplugin-rbac.yaml
kubectl delete -f sc.yaml
