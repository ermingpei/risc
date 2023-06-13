#kubectl create secret -n kube-system generic cloud-config --from-file=/etc/kubernetes/cloud-config
kubectl create secret -n kube-system generic cloud-config --from-literal=cloud.conf="$(cat /etc/kubernetes/cloud-config)" -o yaml > cloud-config-secret.yaml
kubectl apply -f cloud-config-secret.yaml 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/cloud-provider-openstack/master/manifests/controller-manager/cloud-controller-manager-roles.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/cloud-provider-openstack/master/manifests/controller-manager/cloud-controller-manager-role-bindings.yaml

kubectl apply -f openstack-cloud-controller-manager-ds.yaml

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml


