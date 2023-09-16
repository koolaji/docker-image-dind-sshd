docker build --network host -f Dockerfile_podman -t koolaji/pdoman-ssh-git:rhel-8-0.1 .
docker  push   koolaji/pdoman-ssh-git:rhel-8-0.1 
#docker rm -f  podman-sshd
#docker run -p 4848:22 --privileged --name podman-sshd --hostname podman-sshd --network bridge -d koolaji/pdoman-ssh-git:rhel-8-0.1
#sleep 5
#docker ps -a
#docker logs -f podman-sshd
#docker exec -ti docker-sshd passwd
