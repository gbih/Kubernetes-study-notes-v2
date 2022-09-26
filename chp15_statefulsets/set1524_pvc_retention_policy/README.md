# 15.2.4 Changing the PersistentVolumeClaim retention policy


### Objective

1. Explore how to best use the persistentVolumeClaimRetentionPolicy API to either save or retain PVCs during scaling up and down.

### Implementation

PersistentVolumeClaim retention policy is still an alpha-level feature.

To have this policy be honored by the StatefulSet controller, we have to enable the feature gate `StatefulSetAutoDeletePVC`.


To do this on microk8s:

* Stop microk8s

```bash
microk8s stop
```

* Edit the Kube api-server config file, adding the --feature-gates StatefulSetAutoDeletePVC argument 

```bash
sudo vi /var/snap/microk8s/current/args/kube-apiserver

# Add this line
--feature-gates=StatefulSetAutoDeletePVC=true
```


The kube-apiserver file should look like this:

```
--cert-dir=${SNAP_DATA}/certs
--service-cluster-ip-range=10.152.183.0/24
--authorization-mode=AlwaysAllow
--service-account-key-file=${SNAP_DATA}/certs/serviceaccount.key
--client-ca-file=${SNAP_DATA}/certs/ca.crt
--tls-cert-file=${SNAP_DATA}/certs/server.crt
--tls-private-key-file=${SNAP_DATA}/certs/server.key
--kubelet-client-certificate=${SNAP_DATA}/certs/server.crt
--kubelet-client-key=${SNAP_DATA}/certs/server.key
--secure-port=16443
--token-auth-file=${SNAP_DATA}/credentials/known_tokens.csv
--allow-privileged=true
--service-account-issuer='https://kubernetes.default.svc'
--service-account-signing-key-file=${SNAP_DATA}/certs/serviceaccount.key
--event-ttl=5m
--profiling=false

# Enable the aggregation layer
--requestheader-client-ca-file=${SNAP_DATA}/certs/front-proxy-ca.crt
--requestheader-allowed-names=front-proxy-client
--requestheader-extra-headers-prefix=X-Remote-Extra-
--requestheader-group-headers=X-Remote-Group
--requestheader-username-headers=X-Remote-User
--proxy-client-cert-file=${SNAP_DATA}/certs/front-proxy-client.crt
--proxy-client-key-file=${SNAP_DATA}/certs/front-proxy-client.key
#~Enable the aggregation layer
--etcd-servers=https://127.0.0.1:12379
--etcd-cafile=${SNAP_DATA}/certs/ca.crt
--etcd-certfile=${SNAP_DATA}/certs/server.crt
--etcd-keyfile=${SNAP_DATA}/certs/server.key

--feature-gates=StatefulSetAutoDeletePVC=true
```


* Restart microk8s 
```bash
microk8s start
```

### Notes

In the end, the book recommends NOT setting either retention policy to Delete. This is to reduce the probability of losing data accidentally. After this chapter material has been explored, be sure to revert back the kube-apiserver file, or set this feature-gates argument to false:

```
--feature-gates=StatefulSetAutoDeletePVC=false
```

