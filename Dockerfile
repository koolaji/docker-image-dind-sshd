FROM docker

#ENV DOCKER_COMPOSE_VERSION 1.8.0
#ENV COMPOSE_API_VERSION=1.18


RUN apk add --no-cache \
	btrfs-progs \
	e2fsprogs \
	e2fsprogs-extra \
	iptables \
	xfsprogs \
	xz \
	py3-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make \
	openssh \
	rsyslog \
	git \
	&& pip install --upgrade pip 
RUN     pip install "pyyaml<6.0.0,!=5.4.0,!=5.4.1"\
	&& pip install -U docker-compose \
	&& rm -rf /root/.cache \
	&& chmod +x /usr/local/bin/dind \
	&& mkdir -p /root/.docker/ /root/.ssh/ \
	&& touch /root/.docker/config.json \
	&& touch /root/.ssh/authorized_keys \
	&& chmod u=rwx,g=,o= /root/.ssh \
	&& chmod u=r,g=,o= /root/.ssh/authorized_keys \
	&& rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
# TODO aufs-tools



RUN wget "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" -O /usr/local/bin/dind \
	&& chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/
COPY run.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 22

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
ENV DOCKER_HOST tcp://127.0.0.1:2375
ENTRYPOINT ["run.sh"]
CMD []
