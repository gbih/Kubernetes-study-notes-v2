# 13.3.2 Updating the Pod template


### Objective

1. Understand how the ReplicaSet Pod template handles updates.

### Notes

* To add a label to the Pods that the ReplicaSet creates, we have to add the label it its Pod template.

* We cannot add a label with the `kubectl label` command, since that would be added to the ReplicaSet itself, and not to the Pod template.

* We have to edit the manifest YAML file for updates of this nature.

