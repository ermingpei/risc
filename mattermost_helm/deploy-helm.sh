helm install mattermost-team  mattermost/mattermost-team-edition   --set mysql.mysqlUser=mattermost --set mysql.mysqlPassword=M@tterM0st

NAME: mattermost-team
LAST DEPLOYED: Wed Aug  3 20:45:24 2022
NAMESPACE: mattermost
STATUS: deployed
REVISION: 1
NOTES:
You can easily connect to the remote instance from your browser. Forward the webserver port to localhost:8065

- kubectl port-forward --namespace mattermost $(kubectl get pods --namespace mattermost -l "app.kubernetes.io/name=mattermost-team-edition,app.kubernetes.io/instance=mattermost-team" -o jsonpath='{ .items[0].metadata.name }') 8080:8065


To expose Mattermost via an Ingress you need to set host and enable ingress.

helm install --set host=mattermost.yourdomain.com --set ingress.enabled=true stable/mattermost-team-edition
