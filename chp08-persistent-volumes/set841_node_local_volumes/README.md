# 8.4.1 Creating local persistent volumes

### Objective

1. Explore attaching a disk to a specific cluster node

### Notes

1. Locally attached persistent volumes need to be provisioned manually.
2. This storage class represents locally attached volumes that can only be accessed within the nodes to which they are physically connected.

### Directions

1. Run `SETUP_WORKER.sh` first, logged outside of the node instances (this calls multipass).
2. Then run `RUN.sh` while logged into the main node.
