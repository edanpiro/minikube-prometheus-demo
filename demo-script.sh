# script for minikube demo

# install xhyve driver - less resource overhead for the vm
# https://github.com/kubernetes/minikube/blob/master/DRIVERS.md#xhyve-driver
# brew install docker-machine-driver-xhyve

# install minikube
# https://github.com/kubernetes/minikube/releases

# create a cluster. driver is important!

minikube start

# install kubectl on Ubuntu

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl


# check that cluster is working
kubectl config set-context minikube

kubectl get componentstatus

kubectl cluster-info

# deploy an application and a service
# describe a namespace, deployment, and a service

kubectl apply -f monitoring-namespace.yaml
kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml

# view via CLI:
kubectl get services -n monitoring
kubectl get deployments -n monitoring

# show the dashboard
minikube dashboard

# show node ports under services for prometheus. exposes

# show prometheus service

minikube service -n monitoring prometheus

# click around
# show /targets

# show graph and query of container_memory_usage_bytes{namespace="monitoring"}

# deploy grafana
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml

# show grafana
minikube service -n monitoring grafana

# add datasource. make sure type is prometheus http://prometheus:9090
# describe kubernetes DNS

# create a graph:
#  container_memory_usage_bytes{namespace="monitoring"}
# {{kubernetes_pod_name}

# lets add node metrics
# deploy node exporter. explain daemonser
kubectl apply -f node-exporter-daemonset.yml

# show new target in prometheus. explain it autodiscovering the pods

# now create a graph

# node_load1
# {{kubernetes_pod_node_name}}
