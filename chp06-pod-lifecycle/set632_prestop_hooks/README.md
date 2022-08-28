# 6.3.2 Using pre-stop hooks to run a process just before the container terminates

## Objectives

1. Explore using a pre-stop hook in containers.


## Notes

1. A pre-stop hook can be used to initiate a graceful shutdown of the container or to perform additional operations without having to implement them in the application itself. 
2. As with post-start hooks, you can either execute a command within the container or send an HTTP request to the application running in it.