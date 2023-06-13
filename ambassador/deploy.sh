#https://www.getambassador.io/docs/edge-stack/latest/tutorials/getting-started
#Ignore all the cloud/webgui steps

#Warning: There is a known issue with the emissary-apiext service that impacts all Ambassador Edge Stack 2.x and 3.x users. Specifically, the TLS certificate used by apiext expires one year after creation and does not auto-renew. All users who are running Ambassador Edge Stack/Emissary-ingress 2.x or 3.x with the apiext service should proactively renew their certificate as soon as practical by running kubectl delete --all secrets --namespace=emissary-system to delete the existing certificate, and then restart the emissary-apiext deployment with kubectl rollout restart deploy/emissary-apiext -n emissary-system. This will create a new certificate with a one year expiration. We will issue a software patch to address this issue well before the one year expiration. Note that certificate renewal will not cause any downtime.

#1. Install Ambassador
helm repo add datawire https://app.getambassador.io
helm repo update

#kubectl apply -f https://app.getambassador.io/yaml/edge-stack/3.0.0/aes-crds.yaml
kubectl apply -f aes-crds.yaml
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system

sleep 60

[[ $? == 0 ]] && helm install -n ambassador --create-namespace \
     edge-stack datawire/edge-stack && \
kubectl rollout status  -n ambassador deployment/edge-stack -w

# Deploy a Listener
kubectl apply -f listener-http-https-XFP.yaml

# To use Ambassador as an api-getway to map different hostnames to different backend services:
  #0. Install the listner if not done yet, host-wildcard, and filters for authentication
    #ka -f listener-http-https-XFP.yaml

    #If using Google OIDC
    #ka -f google-oidc-filter.yaml        
    #ka -f google-oidc-filterpolicy.yaml  


  #1. For each service, install&Apply host-servicename.yaml, add the service public url to the filter callback urls.
    ka -f host-wildcard.yaml

    ka -f host-nginx.yaml

  #2. Under the service namespace, install&apply mapping file, to map each service under their own namespace such as default or jhub

    ka -f mapping-nginx.yaml

  #If necessary, enable TLS for each service(443)

