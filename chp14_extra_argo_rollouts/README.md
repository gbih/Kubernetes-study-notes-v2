# Study Notes for Kubernetes In Action, v2


## Chapter 14: Extra - Implementing other deployment strategies


### Objectives

* Install a working version of Argo Rollouts


### Installation

* Install on the main node.


#### Controller Installation

* Kubernetes cluster with argo-rollouts controller installed

```
kubectl create namespace argo-rollouts

curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

kubectl apply -f install.yaml


# Or, do in one step:

kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```

---

#### Kubectl Plugin Installation

The kubectl plugin is optional, but is convenient for managing and visualizing rollouts from the command line.

1. Install Argo Rollouts Kubectl plugin with curl.
```
curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64
```

2. Make the kubectl-argo-rollouts binary executable.
```
chmod +x ./kubectl-argo-rollouts-linux-amd64
```

3. Move the binary into your PATH.
```
sudo mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts
```

4. Test to ensure the version you installed is up-to-date:
```
kubectl argo rollouts version
```

---

#### Demo

curl -LO  https://raw.githubusercontent.com/argoproj/argo-rollouts/master/docs/getting-started/basic/rollout.yaml

curl -LO https://raw.githubusercontent.com/argoproj/argo-rollouts/master/docs/getting-started/basic/service.yaml

```
kubectl apply -f rollout.yaml
kubectl apply -f service.yaml
```

---

### Reference

* Getting Started:
	- https://github.com/argoproj/argo-rollouts/blob/master/docs/installation.md#kubectl-plugin-installation
