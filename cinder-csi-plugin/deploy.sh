kubectl apply -f cinder-csi-controllerplugin-rbac.yaml
kubectl apply -f cinder-csi-nodeplugin-rbac.yaml
kubectl apply -f cinder-csi-driver.yaml
kubectl apply -f cinder-csi-controllerplugin.yaml
sleep 30
#Copy cloud-config and /etc/ssl/certs/ca.pem to all worker nodes, and run
kubectl apply -f cinder-csi-nodeplugin.yaml
kubectl apply -f sc.yaml
