#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

emulate_ssd () {
	node_worker=$1
	echo "Emulate the installation of the SSD in the worker node (not the main node):"
	echo ""
	echo "Run this while logged out of the multipass nodes."
	echo ""

	echo "Create /mnt/ssd1 on $node_worker:"
	echo 'multipass exec $node_worker -- bash -c "sudo rm -fr /mnt/ssd1"'
	multipass exec $node_worker -- bash -c "sudo rm -fr /mnt/ssd1"

	echo 'multipass exec $node_worker -- bash -c "sudo mkdir -p /mnt/ssd1"'
	multipass exec $node_worker -- bash -c "sudo mkdir -p /mnt/ssd1"

	echo 'multipass exec $node_worker -- bash -c "sudo chmod 666 -R /mnt/ssd1"'
	multipass exec $node_worker -- bash -c "sudo chmod 666 -R /mnt/ssd1"

	echo 'multipass exec $node_worker -- bash -c "ls -l /mnt"'
	multipass exec $node_worker -- bash -c "ls -l /mnt"

	echo $HR
}

emulate_ssd 'worker1'