ARG ARCH=
FROM alpine:latest

COPY start.sh /start.sh

# install SSH and delete the cached install files
RUN apk add --update openssh-client 
RUN rm -rf /var/cache/apk/*;

# change permissions of script to allow execution
RUN chmod +x /start.sh

# Expose the ports that can be used for the local tunnels
EXPOSE 10000-10100

# run ssh command to start the tunnel
CMD /start.sh