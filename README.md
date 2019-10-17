## apache-ajp 
 
### Run 
- sudo docker run -p 443:443 -p 8080:80 -e NODES='PPM_MULTINODE:16.186.78.162:25202,PPM_MULTINODE2:16.186.78.162:25302,PPM_MULTINODE3:16.186.77.158:25402,PPM_MULTINODE4:16.186.77.158:25502' -d snzip/apache-ajp

### Parameters
- NODES
server_name. ( The name of the Tomcat needs to be equal to the value of the jvmRoute attribute in the Engine element of each Tomcat's server.xml.)
- IP
- ajp port
### Reference
- https://tomcat.apache.org/connectors-doc/common_howto/loadbalancers.html

### Docker image 
- https://hub.docker.com/r/snzip/apache-ajp
