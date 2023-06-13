# Refer to: https://github.com/ceph/ceph-csi/blob/2a8eb959667d598da7cdd3bccd15cb64107e83f4/docs/deploy-cephfs.md

#Build cephcsi
##cd /root/ceph-csi
   #Building binary:
    ## make cephcsi
   #Building Docker image:
    ## make image-cephcsi

#NOTE: To make CephFS CSI driver version >= 1.1.0 work with Ceph v14.2.2 cluster (not deployed by rook), you need to add the following settings in the mgr section of the ceph.conf used by the Ceph manager daemon, and restart the Ceph manager daemon.
## [mgr]
## client mount uid = 0
## client mount gid = 0



######After-reset######
kubectl create -f csi-provisioner-rbac.yaml
kubectl create -f csi-nodeplugin-rbac.yaml
kubectl create -f csi-provisioner-psp.yaml
kubectl create -f csi-nodeplugin-psp.yaml
kubectl create -f ceph-csi-config.yaml
kubectl create -f ceph-config.yaml
kubectl create -f csi-cephfsplugin-provisioner.yaml
sleep 30
kubectl create -f csi-cephfsplugin.yaml
kubectl create -f secret.yaml
kubectl create -f sc.yaml

# for stable functionality replace canary with latest release version
 #   image: quay.io/cephcsi/cephcsi:canary
#Check the release version here.

#Verifying the deployment in Kubernetes

kubectl get all -A |grep ceph
