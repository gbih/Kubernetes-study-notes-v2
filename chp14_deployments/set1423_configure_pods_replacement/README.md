# 14.2.3 Configuring how many Pods are replaced at a time


### Objective

1. Explore how the two parameters maxSurge and maxUnavailable affect how fast Pods are replaced during a rolling update.

### Notes

* The parameters maxSurge and maxUnavailable are set in the rollingUpdate subsection of the Deployment's strategy field.

* The default value for maxSurge and maxUnavailable is 25%.