echo "USAGE: upgrade.sh deploy_name, e.g. jhub200"
helm upgrade --cleanup-on-fail $1 jupyterhub/jupyterhub -f values.yaml

