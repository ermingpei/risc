helm repo add cern https://registry.cern.ch/chartrepo/cern
helm repo update
helm install cvmfs ./deployments/helm/cvmfs-csi
