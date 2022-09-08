# 9.4.3 Using a downwardAPI volume to expose pod metadata as files

### Objective

1. Explore the Downward API to project pod metadata as files into the container's filesystem using the `downwardAPI` volume type.

### Notes

This is similar to projecting config maps and secrets as files into the container's filesystem, except we use the `downwardAPI` here.