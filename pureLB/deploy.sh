cat <<EOF | sudo tee /etc/sysctl.d/k8s_arp.conf
net.ipv4.conf.all.arp_ignore=1
net.ipv4.conf.all.arp_announce=2

EOF
sudo sysctl --system

# Installation
kubectl apply -f purelb-complete.yaml
[[ $? != 0 ]] && kubectl apply -f purelb-complete.yaml
kubectl apply -f purelbServiceGroup.yaml 

