FROM redhat/ubi8:8.8-854

RUN  dnf update -y  
RUN  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
RUN  dnf install docker-ce --nobest -y
RUN  dnf install openssh-server vim net-tools git -y
COPY dockerd-entrypoint.sh /usr/local/bin/
COPY run.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 22

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
ENV DOCKER_HOST tcp://127.0.0.1:2375
RUN cp /usr/libexec/docker/docker-init /usr/bin/
ENTRYPOINT ["run.sh"]
CMD []
