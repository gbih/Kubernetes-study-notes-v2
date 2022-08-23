#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "You may need to restart one of the nodes to ensure that the events are recent enough to still be present in etcd."
echo ""

echo "kubectl get events -o wide -A"
kubectl get events -o wide -A
echo $HR


echo "kubectl get ev --field-selector type=Warning -A"
kubectl get ev --field-selector type=Warning -A



# echo "kubectl get nodes"
# kubectl get nodes
# enter

# echo "kubectl get node actionbook-v2 -o yaml"
# kubectl get node actionbook-v2 -o yaml
# enter

# echo "Accessing the API directly via 'kubectl proxy'"
# echo "We can now access the Kubernetes API using HTTP at 127.0.0.1:8001"
# echo ""
# echo "kubectl proxy &"
# kubectl proxy &

# sleep 2
# enter

# echo "curl 127.0.0.1:8001"
# echo ""
# curl 127.0.0.1:8001
# enter

# echo "Kill process proxy process listening on port 8001"
# fuser 8001/tcp -k