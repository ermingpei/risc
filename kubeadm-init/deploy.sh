kubeadm init --config=kubeadm-config.yaml
#For normal user:
##mkdir -p $HOME/.kube
##sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
##sudo chown $(id -u):$(id -g) $HOME/.kube/config

#For root
export KUBECONFIG=/etc/kubernetes/admin.conf



