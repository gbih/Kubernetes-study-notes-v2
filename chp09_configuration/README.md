# Study Notes for Kubernetes In Action, v2

## Chapter 9: Configuration via ConfigMaps, Secrets, and the Downward API

### Objectives
- Setting the command and arguments for the container's main process
- Setting environment variables
- Storing configuration in config maps
- Storing sensitive information in secrets
- Using the Downward API to expose pod metadata to the application
- Using configMap, secret, downwardAPI and projected volumes

### Notes

Overall aim is to learn how three special volume types can be used to inject values from config maps, secrets and the Pod object itself. 