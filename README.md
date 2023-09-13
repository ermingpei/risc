# RISC

RISC stands for Research Interactive Services and Collaboration, a Kubernetes&Openstack-based platform, on top of which multiple applications can be rapidly deployed and maintained with enjoying its flexibility and resilliance.  
RISC features load-balancing, multiple storage backends, single-sign-on, auto-mapping, and auto-scaling (under-development), etc.
The aim of RISC project is to provide end-users the convenience of using different applications, as well as system admins a rapid deployment environment behind those applications. 

## Main components

### 1. A Kubernetes cluster, created with using kubeadm
It includes the following core-components:
* Kubernetes controller-manager/apiserver/scheduler/etcd/proxy/coredns/etc
* Openstack-cloud-controller
* Cinder-CSI
* Cephfs-CSI
* Manila-CSI
* Weave-CNI
* Worker nodeplugins

### 2. PureLB, Load-balancer
* An Allocator
* A lbnodeagent for each worker node

### 3. Ambassador, Ingress-controller and API-gateway
* Ingress-controller, edge-stack
* API-gateway, emissary
* Host/Listener/Mapping
* OIDC adaptor (Google and Alliance IdPs)

### 4. CVMFS-CSI
* A dedicated CVMFS deployment/daemonset that provides CVMFS software repos to different applications.

### 5. Cert-Manager
* Certificate management tool

### 6. Applications (examples)
* Nginx
* Jupyterhub
* Overleaf
* Mattermost

Note: More applications can be added to this platform using the same approach shown in `setup_fullchain.sh`. 

## To deploy (single-master mode)
### 1. System requirements
The code is verified on CentOS 7 however it can be run on most Linux distributions with a bit tweaks. An operating system with above 8 CPU cores, 16GB RAM and 100GB disk space is recommended. Minimum requirements can be at 2 vCPUs, 8GB RAM and 50GB disk space.  
### 2. Hosts
For a proof-of-concept, it minimumly needs two VMs with the above system requirements. One will be the master node and the other will be a worker node.  
### 3. Cloud CA certificate
Download the CA certificate of the cloud service provider (for Openstack, from the Horizon dashboard) and place it into /etc/ssl/certs
### 3. Cloud config 
Create a cloud-config file. Refer to the template auth/cloud-config.
### 4. Kictstart
Now, simply run the automation script (`setup_fullchain.sh`) on the master node it will automatically create the control plane and set up the worker and then deploy all the above components on both nodes. 
### 5. Grow it
More worker nodes can be easily added to the cluster and will be automatically deployed/configured, by runnig the following commands:
```
export KUBEADM_JOIN_COMMAND=`kubeadm token create --print-join-command`
ssh $WORKER $KUBEADM_JOIN_COMMAND
```

## Author and contact
erming.pei at westdri.ca

