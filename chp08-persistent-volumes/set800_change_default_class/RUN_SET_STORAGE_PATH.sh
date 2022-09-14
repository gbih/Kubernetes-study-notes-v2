#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

# Set the default StorageClass on microk8s

target_storage_class='openebs-jiva-csi-default'
#target_storage_class='openebs-hostpath'
#target_storage_class='microk8s-hostpath'

#####


echo "May need to adjust openebs-jiva-csi-default to modify 'volumeBindingMode: WaitForFirstConsumer'"
kubectl delete sc openebs-jiva-csi-default
sleep 0.5
kubectl apply -f openebs-jiva-csi-default.yaml
sleep 1
echo ""
kubectl get sc openebs-jiva-csi-default
echo $HR




kubectl get sc | sort

echo $HR 

echo "Determine which StorageClass is marked as default:"

# Split on what is returned by grep, 
# Then we use the 'cut' command to essentially split:
# -f (field number), so here we want the first slice
# cut uses tab as a default field delimiter, so we need to change to space:
# -d option uses space as a field separator or delimiter
# https://www.geeksforgeeks.org/cut-command-linux-examples/

current_storage_class=$(kubectl get sc | grep '(default)' | cut -d ' ' -f 1)
echo $current_storage_class
echo $HR

mark_non_default () {
	current_sc=$1
	echo "Mark the default StorageClass $current_sc as non-default:"
	kubectl patch sc $current_sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
}

mark_default () {
	target_sc=$1
	echo "Mark $target_sc StorageClass as default:"
	kubectl patch storageclass $target_sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
}

if [ $current_storage_class != $target_storage_class ]
then
	echo "Current StorageClass is not $target_storage_class."
	mark_non_default $current_storage_class
	echo $HR
	mark_default $target_storage_class
	echo $HR
	kubectl get sc | sort

else
	echo "Current StorageClass is already $target_storage_class, no need to change."
fi

enter


echo "Check that the /etc/hosts file on main has been set correctly (has entries for both main and worker nodes)"
echo ""
cat /etc/hosts


echo $HR_TOP