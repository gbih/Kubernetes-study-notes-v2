#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Explore changing the default StorageClass on microk8s"
echo $HR 

echo "1. List the StorageClasses in your cluster:"
echo ""
echo "kubectl get sc"
kubectl get sc
echo ""

echo $HR 


echo "2. Mark the default StorageClass as non-default:"
echo ""
echo 'kubectl patch sc microk8s-hostpath -p {"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch sc microk8s-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
echo ""
echo "kubectl get sc"
kubectl get sc

echo $HR 


echo "3. Mark a StorageClass as default:"
echo ""
echo 'kubectl patch storageclass openebs-hostpath -p {"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageclass openebs-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
echo ""
echo "kubectl get sc"
kubectl get sc

echo $HR 


echo "kubectl get sc openebs-hostpath -o yaml"
kubectl get sc openebs-hostpath -o yaml

# apiVersion: storage.k8s.io/v1
# kind: StorageClass
# metadata:
#   annotations:
#     cas.openebs.io/config: |
#       - name: StorageType
#         value: "hostpath"
#       - name: BasePath
#         value: "/var/snap/microk8s/common/var/openebs/local"
#     meta.helm.sh/release-name: openebs
#     meta.helm.sh/release-namespace: openebs
#     openebs.io/cas-type: local
#     storageclass.kubernetes.io/is-default-class: "true"
#   creationTimestamp: "2022-09-06T06:24:40Z"
#   labels:
#     app.kubernetes.io/managed-by: Helm
#   name: openebs-hostpath
#   resourceVersion: "12139"
#   uid: 52f620f5-3ac9-4a96-9d24-6c1aa58d0039
# provisioner: openebs.io/local
# reclaimPolicy: Delete
# volumeBindingMode: WaitForFirstConsumer