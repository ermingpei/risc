
openssl req -newkey rsa:2048 -nodes -keyout nginx.key -x509 -days 365 -out nginx.crt 
kubectl create secret generic nginx-certs-keys --from-file=./nginx.crt --from-file=./nginx.key
kubectl create configmap nginxconfigmap --from-file=default.conf
kubectl describe  configmap nginxconfigmap
kubectl create -f nginx-app.yaml

kubectl get service nginxsvc -o json

