kubectl delete -f csi-cephfsplugin.yaml
kubectl delete -f csi-cephfsplugin-provisioner.yaml
kubectl delete -f csi-provisioner-psp.yaml
kubectl delete -f csi-nodeplugin-psp.yaml
kubectl delete -f csi-provisioner-rbac.yaml
kubectl delete -f csi-nodeplugin-rbac.yaml
kubectl delete -f ceph-csi-config.yaml
kubectl delete -f ceph-config.yaml
kubectl delete -f secret.yaml
kubectl delete -f sc.yaml
