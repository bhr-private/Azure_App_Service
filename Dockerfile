FROM tomcat:8.0-alpine
LABEL maintainer="bernhard@hensler.net"

# RUN apk add --update --no-cache openssh 
# RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
# RUN adduser -h /home/bhr -s /bin/sh -D bhr
# RUN echo -n 'bhr:Passw0rd' | chpasswd
# COPY entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
# EXPOSE 22

ADD sample.war /usr/local/tomcat/webapps/
ADD helloworld.html /usr/local/tomcat/webapps/examples/

EXPOSE 8080
CMD ["catalina.sh", "run"]
