#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

# Reference: https://docs.docker.com/engine/reference/run/

echo """
Run a special container configured to use the VM’s namespaces to run a remote shell.

docker run --net=host --ipc=host --uts=host --pid=host --privileged 
--security-opt=seccomp=unconfined -it --rm alpine

This long command requires explanation:
* The container is created from the alpine image.
* The --net, --ipc, --uts and --pid flags make the container use the host’s
namespaces instead of being sandboxed, and the --privileged and --security-opt
flags give the container unrestricted access to all sys-calls.
* The -it flag runs the container interactive mode and the --rm flags ensures the
container is deleted when it terminates.
* The -v flag mounts the host’s root directory to the /host directory in the container.
The chroot /host command then makes this directory the root directory in the container .
After you run the command, you are in a shell that’s effectively the same as if you had used SSH to enter the VM. Use this shell to explore the VM - try listing processes by executing the ps aux command or explore the network interfaces by running ip addr.
"""

docker run --net=host --ipc=host --uts=host --pid=host --privileged \
--security-opt=seccomp=unconfined \
-it --rm \
alpine


