kc ns mattermost-operator
kc -f mattermost-operator.yaml

kc ns mysql-operator
kc -f mysql-operator.yaml

kc ns minio-operator
kc -f minio-operator.yaml

kc ns mattermost
kc -f mattermost_mysql_minio_operators_small.yaml
