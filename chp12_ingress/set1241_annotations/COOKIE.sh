#!/bin/bash
source ../../common/setup.sh
echo $HR

# Original response to "curl --silent -I http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1"

# HTTP/1.1 200 OK
# Date: Tue, 20 Sep 2022 08:12:10 GMT
# Content-Type: text/plain
# Connection: keep-alive
# Set-Cookie: SESSION_COOKIE=1663661531.322.715.719150|f4cd5cb3890a8745725b6cd978e1ff48; Path=/; HttpOnly

# We want to filter out SESSION_COOKIE=1663661531.322.715.719150|f4cd5cb3890a8745725b6cd978e1ff48'
# Ugly but workable..

echo "Retrieve cookie, then clean up:"
echo ""
resp1=$(curl --silent -I http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1); echo $resp1
resp2=$(echo $resp1 | cut -d ';' -f 1 | xargs); echo $resp2
resp3=$(echo $resp2 | awk -F 'Set-Cookie:' '{print $2}'); echo $resp3
echo $HR 

echo "Include session cookie in request. The HTTP request should always be forwarded to the same pod, indicating session affinity is using the cookie."
echo ""
for i in {1..10} 
do
	curl -s -H "Cookie: $resp3" http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1 | grep "Request processed"
done

echo $HR 

echo "Do not include session cookie in request. This should result in the ingress doing load-balancing among the different pods."
echo ""
for i in {1..10} 
do
	curl -s http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1 | grep "Request processed"
done