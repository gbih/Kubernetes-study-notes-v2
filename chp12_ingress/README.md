# Study Notes for Kubernetes In Action, v2

## Chapter 12: Exposing Pods with Ingress

### Objectives

* Create Ingress objects
* Deploy and understand Ingress controllers
* Secure Ingresses with TLS
* Add additional configuation to an Ingress
* Use IngressClasses when multiple controllers are installed
* Use Ingresses with non-service backend


### Notes

* Think of Ingresses as the router-aspect of a regular web application. It also exhibits HTTP functionality common to a web-app (eg authentication, cookie-based session affinity, URL rewriting, etc)

* In Kubernetes, an Ingress is a way for external clients to access the services of applications running in the cluster. The Ingress function consists of three components:
	1. Ingress API object: define and configure an ingress
	2. L7 laod balancer or reverse proxy: routes traffic to the backend servcies.
	3. Ingress controller: monitors the Kubernetes API for Ingress objects and deploys and configures the load balancer or reverse proxy.

	









