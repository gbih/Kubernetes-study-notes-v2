# 6.3.1b Using an httpGet post-start hook to access a web-service

## Objectives

1. Explore using an httpGet post-start hook to jsonplaceholder.typicode.com/posts

## Notes

1. As with command-based post-start hooks, the HTTP GET post-start hook is executed at the same time as the container's main process. 
2. These types of lifecycle hooks are applicable only to a limited set of use-cases.
3. If you configure the hook to send the request to the container its defined in, you'll be in trouble if the container's main process isn't yet ready to accept requests.
