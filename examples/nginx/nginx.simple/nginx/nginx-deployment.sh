kubectl create deployment nginx --image=nginx

#kubectl expose deployment nginx --name=nginx-service --port=80 --target-port=8080 --type=LoadBalancer
