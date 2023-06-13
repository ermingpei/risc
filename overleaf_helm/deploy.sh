helm install my-redis bitnami/redis
helm install my-mongodb bitnami/mongodb --version 11.2.0 --set auth.enabled=false

export REDIS_PASSWORD=$(kubectl get secret --namespace overleaf my-redis -o jsonpath="{.data.redis-password}" | base64 -d)
helm install overleaf --set env.REDIS_HOST="my-redis-master.overleaf.svc.cluster.local",env.SHARELATEX_REDIS_HOST="my-redis-master.overleaf.svc.cluster.local",env.SHARELATEX_REDIS_PASS=$REDIS_PASSWORD,env.SHARELATEX_MONGO_URL="mongodb://my-mongodb.overleaf.svc.cluster.local/sharelatex" k8s-at-home/overleaf

#To change the overleaf service from ClusterIP to LoadBalancer:
kubectl patch service overleaf -p '{"spec": {"type": "LoadBalancer"}}'

#To create user accounts:
  # To create the admin account:
    https://overleaf.risc.c3.ca/launchpad
  # To create normal user accounts:
    https://overleaf.risc.c3.ca/launchpad/admin/register

