docker build --network host -t koolaji/dind-ssh-git:rhel-8-0.1 .
docker rm -f  docker-sshd
docker run -p 4848:22 --privileged --name docker-sshd --hostname docker-sshd -d docker.io/koolaji/dind-ssh-git:rhel-8-0.1
sleep 5
docker ps -a
docker logs -f docker-sshd
#docker exec -ti docker-sshd passwd
