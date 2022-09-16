

https://discuss.kubernetes.io/t/addon-openebs/15229/8

Hi @balchua1 - I work at MayaData. We built, and continue to build with other contributors, the OpenEBS project on the CNCF.

A note about our implementation of cStor - admittedly, the performance is not that great. We see far more hostpath/Local PV usage of OpenEBS than cStor.

That said, we’re actively building a storage layer called MayaStor, that focuses on performance, and can be used instead of cStor. MayaStor specifically works with NVMe’s (open source NVMeOF) and we’re documenting how to use this @ Welcome to Mayastor! - Mayastor Reference 9

https://mayastor.gitbook.io/introduction/

---

A cStor pool is local to a node in OpenEBS. A pool on a node is an aggregation of set of disks which are attached to that node. A pool contains replicas of different volumes, with not more than one replica of a given volume. OpenEBS scheduler at run time decides to schedule replica in a pool according to the policy.

---
microk8s kubectl -n openebs get pods -o wide
microk8s kubectl get blockdevice -n openebs
lsblk


I checked the iptables they seem to be incomplete.
It also seems like it is using nftables instead of the legacy. I have not used the nftables myself only iptables-legacy.
If you are keen perhaps using the iptables legacy can help.
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy

---

https://github.com/canonical/microk8s/issues/2405





