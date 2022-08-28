# 6.3.1 Using post-start hooks to perform actions when the container starts

## Objectives

1. Run additional processes every time a container starts and just before it stops.
2. Use a post-start hook to install the `fortune` software package, then run its output to a file that Nginx can serve. We create a quote-poststart pod for this.


## Notes

1. We implement post-start hooks via adding lifecycle-hooks to the container.
2. There are two types of lifecycle hooks:
	a. Post-start hooks
	b. Pre-stop hooks
3. These lifecycle hooks are specified per container, unlike init containers (which are specified at pod level).
4. Like liveness probes, lifecycle hooks can be used to either:
	a. Execute a command inside the container
	b. Send a HTTP GET request to the application in the container
