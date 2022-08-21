# Chapter 2, Section 2.22 Creating a Dockerfile for the image

## Objectives
1. Build Node script with Dockerfile (Node base image) 
2. Push to DockerHub
3. Pull from DockerHub

---

## Setup

Create Node script as `app.js` in ./src

Use prepared script from GitHub repo for *[kubernetes-in-action-2nd-edition](https://github.com/luksa/kubernetes-in-action-2nd-edition/blob/master/Chapter02/kiada-0.1/app.js)*


```javascript
const http = require('http');
const os = require('os');
const fs = require('fs');

const version = "0.1";
const listenPort = 8080;

function sendResponse(status, contentType, encoding, body, response) {
    response.writeHead(status, {'Content-Type': contentType});
    response.write(body, encoding);
    response.end();
}

function renderFile(req, res, path, contentType) {
    let template = fs.readFileSync(path, 'utf8');

    let map = Object.assign({
        "{{hostname}}": os.hostname(),
        "{{clientIP}}": req.connection.remoteAddress,
        "{{version}}": version,
    });

    let body = template.replace(
        new RegExp(Object.keys(map).join('|'), 'g'),
        function (matched) {
            return map[matched];
        });

    sendResponse(200, contentType, 'utf8', body, res);
}

function sendFile(req, res, path, contentType) {
    let body = fs.readFileSync(path, 'binary');
    sendResponse(200, contentType, 'binary', body, res);
}

// this function guesses if the client that sent the request is a full-fledged
// graphical web browser and not a text-based tool such as curl
// graphical browsers typically send accept: text/html,application/xhtml+xml,...
// curl sends accept: */*
function isGraphicalWebBrowser(req) {
    let accept = req.headers.accept || "*/*";
    return accept.startsWith("text/html");
}

function handler(req, res) {
    let clientIP = req.connection.remoteAddress;
    console.log("Received request for " + req.url + " from " + clientIP);
    switch (req.url) {
        case '/':
            if (isGraphicalWebBrowser(req)) {
                res.writeHead(302, {"Location": "html"});
                res.write("Redirecting to the html version...");
                res.end();
                return;
            }
        // text-based clients fall through to the '/text' case
        case '/text':
            return renderFile(req, res, "html/index.txt", "text/plain");
        case '/html':
            return renderFile(req, res, "html/index.html", "text/html");
        case '/stylesheet.css':
            return sendFile(req, res, "html/stylesheet.css", "text/css");
        case '/javascript.js':
            return sendFile(req, res, "html/javascript.js", "text/javascript");
        case '/favicon.ico':
            return sendFile(req, res, "html/favicon.ico", "image/x-icon");
        case '/cover.png':
            return sendFile(req, res, "html/cover.png", "image/png");
        default:
            return sendResponse(404, "text/plain", "utf8", req.url + " not found", res)
    }
}

console.log("Kiada - Kubernetes in Action Demo Application");
console.log("---------------------------------------------");
console.log("Kiada " + version + " starting...");
console.log("Local hostname is " + os.hostname());
console.log("Listening on port " + listenPort);

let server = http.createServer(handler);
server.listen(listenPort);

```

---

Create `Dockerfile` in ./src

```bash
FROM node:16
COPY app.js /app.js
COPY html/ /html
ENTRYPOINT ["node", "app.js"]
```




---

## Docker operations

Build Docker image and tag as `kiada`


```bash
docker build -t kiada ./src --quiet
```


---
Check images


```bash
docker images
```

---
Create new container named `kiada-container` from the `kiada` image. 

The container will be detached from the local console via the -d flag.

Port 8080 on the local machine will be mapped to port 8080 inside the container.



```bash
docker run --name kiada-container -p 8080:8080 -d kiada
```


---
Verify this new container process is running.



```bash
docker ps
```


---
Test via curl (inside the multipass instance)



```bash
curl localhost:8080
```



---
If applicable, run `multipass info actionbook-v2` to find the external IP, and use that for browser access. For example, `http://192.168.64.5:8080/`

---
Explore different Docker operations.


```bash
docker ps
```




```bash
docker stop kiada-container
print("Done")
```





```bash
docker start kiada-container
print("Done")
```




```bash
docker stop kiada-container
docker rm kiada-container
print("Done")
```





```bash
docker rmi kiada
print("Done")
```





```bash
docker images prune
print("Done")
```



---
# Create another image, then push to DockerHub


```bash
docker build -t kiada ./src --quiet
```


---
Add an additional tag for the image. The current name is kiada. We want to tag it as

```bash
<username>/kiada:<version>
``` 

       
    


```bash
docker tag kiada georgebaptista/kiada:0.1
print("Done")
```




```bash
docker images
```



---
If initial login to DockerHub, need to login with username/password, eg
```
docker login --username $USER --password $PASSWORD
```



```bash
docker push georgebaptista/kiada:0.1
```

 

---
## Clean-up (if necessary)


```bash
docker images
```




```bash
docker rmi kiada
```



```bash
docker images
```



```bash
# stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# remove all images
docker rmi $(docker images -a -q)
```




