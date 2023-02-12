# ssh-tunnel-docker

https://hub.docker.com/r/beastarman/ssh-tunnel

Docker image to create a local SSH Tunnel in a container

With thanks to https://hub.docker.com/r/nowsci/sshtunnel which helped me understand the method of starting a tunnel in a docker image.

This is a similar image but has only 100 ports exposed - 10000 - 100100 instead of exposing all ports. Having all ports exposed seemed to create a significant slow down in docker ps, portainer, and android docker apps when using multiple container tunnels.

example docker-compose file:
```
  sshtunnel:
    image: beastarman/ssh-tunnel
    container_name: ssh-tunnel
    ports:
      - "10013:10013"
    volumes:
      - sshtunnel-data:/data/:ro   # point volume or path to location of ssh keys for the tunnel host
        #
    environment:
      - TUNNELHOST=username@123.123.123.123   # username and IP Address or hostname of host
      - TUNNELPORT=22
      - REMOTEHOST=localhost
      - LOCALPORT=10013  # use between 10001-10100
      - REMOTEPORT=1234  # amend to the port of the remote service to tunnel to
      #
      - KEY=/data/sshkey-filename
      #     
    restart: always
    networks:
       sshtunnel: 

networks:
  sshtunnel:
     driver: bridge
     name: sshtunnel

volumes:
  sshtunnel-data:
```
