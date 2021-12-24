#!/bin/bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 curl
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo systemctl start docker
docker run --rm -p 80:8080 bitnami/wordpress-nginx
