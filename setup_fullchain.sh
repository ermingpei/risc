if [ $# != 1 ]; then
  echo "Usage: $0 WORKER_HOSTNAME"
  exit
fi
WORKER=$1
yum -y install git
git clone https://git.computecanada.ca/paas/risc.git
ROOTDIR=`pwd`/risc

echo "Deploy the master and the first worker node: $WORKER"
echo "Reset the master..."
cd $ROOTDIR; ./setup_resetall.sh
echo "Reset the first worker node..."
scp $ROOTDIR/setup_resetall.sh $WORKER:
ssh $WORKER $ROOTDIR/setup_resetall.sh

echo "Install Master..."
$ROOTDIR/setup_master_installation.sh
echo "Initialize with kubeadm..."
cd $ROOTDIR/kubeadm-init; ./deploy.sh
echo  "Deploy the controller manager"
cd $ROOTDIR/controller-manager; ./deploy.sh
sleep 15
kubectl get pod -A -o wide
kubectl get svc -A -o wide

scp $ROOTDIR/setup_workers*.sh $WORKER:
ssh $WORKER $ROOTDIR/setup_workers_installation.sh
sleep 30
scp /etc/kubernetes/cloud-config $WORKER:/etc/kubernetes/cloud-config
scp /etc/ssl/certs/ca.pem $WORKER:/etc/ssl/certs

export KUBEADM_JOIN_COMMAND=`kubeadm token create --print-join-command`
ssh $WORKER $KUBEADM_JOIN_COMMAND
sleep 15
kubectl get pod -A -o wide
kubectl get svc -A -o wide
exit

# Set up pureLB
cd $ROOTDIR/pureLB; ./deploy.sh

# Set up Cinder
cd $ROOTDIR/cinder-csi-plugin; ./deploy.sh
  #To verify:
  # cd $ROOTDIR/examples; kubectl apply -f cinder 

# Set up Cephfs
## If not existed yet, compile cephfs image.
#cd $ROOTDIR/ceph-csi
#make cephcsi
#make image-cephcsi
cd $ROOTDIR/cephfs-csi-plugin; ./deploy.sh
  #To verify:
  # cd $ROOTDIR/examples; kubectl apply -f cephfs 

# Setup Manila
cd $ROOTDIR/manila-csi-plugin; ./deploy.sh
  #To verify:
  # cd $ROOTDIR/examples; kubectl apply -f manila

# Setup CVMFS (optional)
cd $ROOTDIR/cvmfs-csi-2.1.0; ./deploy.sh
  #To verify:
  # cd $ROOTDIR/examples; kubectl apply -f cvmfs
  # kubectl exec -it cvmfs-all-repos -- /bin/sh
    # ls /my-cvmfs/soft.computecanada.ca

# Setup Nginx-tls
cd $ROOTDIR/examples/nginx/nginx.tls/nginx-tls; ./deploy.sh
  #To verify
export NGINX_LB_ENDPOINT=$(kubectl -n default get svc nginxsvc \
  -o "go-template={{range .status.loadBalancer.ingress}}{{or .ip .hostname}}{{end}}")
curl $NGINX_LB_ENDPOINT

# Setup Ingress, such as Ambassador
cd $ROOTDIR/ambassador; ./deploy.sh
  #To verify:
kubectl apply -f host-quote.yaml
kubectl apply -f mapping-quote.yaml
export QUOTE_LB_ENDPOINT=$(kubectl -n ambassador get svc  edge-stack \
  -o "go-template={{range .status.loadBalancer.ingress}}{{or .ip .hostname}}{{end}}")
curl -Lki https://$QUOTE_LB_ENDPOINT/

# At openstack end, associate the public IP to ambassador edge-stack svc LoadBalancer_IP, and then run
curl -Lki https://$PUBLIC_IP/

# Similarly, install other applications and repeat the above steps to do the mapping.  

# SSO, to connect to an OIDC such as Alliance or Google, apply the following filters&filterpolicies 
# cd $ROOTDIR/ambassador
# kubectl apply -f cc-oidc-filter.yaml
# kubectl apply -f cc-oidc-filterpolicy.yaml

# or
# kubectl apply -f google-oidc-filter.yaml
# kubectl apply -f google-oidc-filterpolicy.yaml

#After done the above, it can do mappings from hostnames to LoadBalancer_IPs for multiple applications with just using a single public IP. 


