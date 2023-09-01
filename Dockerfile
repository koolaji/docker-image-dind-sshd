FROM redhat/ubi8:8.8-854

RUN  dnf update -y  
RUN  dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
RUN  dnf install docker-ce --nobest -y
RUN  dnf install openssh-server vim net-tools git sudo python3-pip -y && pip3 install docker
COPY dockerd-entrypoint.sh /usr/local/bin/
COPY run.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 22

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
ENV DOCKER_HOST tcp://127.0.0.1:2375
RUN cp /usr/libexec/docker/docker-init /usr/bin/
RUN curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose \ 
    && chmod +x /usr/local/bin/docker-compose

ENTRYPOINT ["run.sh"]
CMD []
