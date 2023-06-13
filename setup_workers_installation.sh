hostip=`/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1`
hostname=`hostname -s`

echo "$hostip  $hostname" >> /etc/hosts
hostnamectl set-hostname $hostname

yum -y install yum-utils device-mapper-persistent-data lvm2 vim wget git
yum-config-manager   --add-repo   https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
mkdir /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

#yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
yum -y install kubectl-1.22.0 kubeadm-1.22.0 kubelet-1.22.0 kubernetes-cni-0.8.7 --disableexcludes=kubernetes

systemctl enable --now kubelet
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system
lsmod | grep br_netfilter

#on the master node run: 
 ##[root@master1 ~]# kubeadm token create --print-join-command, will get the following string, run it.
#kubeadm join 192.168.1.179:6443 --token hm2lxk.i7s5npvxcv94z35f --discovery-token-ca-cert-hash sha256:3cabb6f68931bad3c3102cb8b3079333dffe2384b039ff88d38ad52efdd99d92 

# After installation, see the setup_workers_after_installation.sh
