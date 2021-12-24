#!/bin/bash
mkdir -p home/project

sudo apt update -y
sudo apt install -y docker docker-compose git

git config --global user.name "Pcbarreto"
git config --global user.email "paullo.barreto@gmail.com"

git clone https://github.com/thejungwon/docker-webapp-django.git

cd docker-webapp-django/
sudo docker-compose -d up
