#!/bin/bash
 
# Rimuovere versioni precedenti di Docker
yum remove -y docker \
              docker-client \
              docker-client-latest \
              docker-common \
              docker-latest \
              docker-latest-logrotate \
              docker-logrotate \
              docker-engine
 
# Aggiornare i pacchetti esistenti
yum update -y
 
# Installare i pacchetti necessari
yum install -y yum-utils \
               device-mapper-persistent-data \
               lvm2
 
# Aggiungere il repository ufficiale Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
 
# Installare Docker
yum install -y docker-ce docker-ce-cli containerd.io
 
# Abilitare e avviare Docker
systemctl enable docker
systemctl start docker
 
# Verificare l'installazione di Docker
docker --version
 
# Creare un volume per Portainer
docker volume create portainer_data
 
# Eseguire il container Portainer
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce
