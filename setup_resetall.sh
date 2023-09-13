kubeadm reset -f

rm -f /etc/containerd/config.toml
systemctl stop containerd
systemctl stop docker
systemctl stop firewalld
systemctl daemon-reload
yum -y remove `rpm -qa|grep kube`
rm -rf /var/lib/kubelet
yum -y remove `rpm -qa|grep docker`
rm -rf /var/lib/docker
yum -y remove `rpm -qa|grep container`
rm -rf /var/lib/containerd
rm -rf /var/lib/etcd
rm -rf /var/lib/cni
rm -rf /var/lib/weave
yum -y remove `rpm -qa|grep firewall`
rm -rf /etc/firewalld
iptables -F
iptables-save > /dev/null
yum -y install ipvsadm
ipvsadm --clear

hostnamectl set-hostname `hostname -s`

