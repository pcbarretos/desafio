#!/bin/bash
sudo apt update -y
sudo apt install nginx wget curl zip unzip docker docker-compose -y


wget https://www.free-css.com/assets/files/free-css-templates/download/page273/bakery.zip
unzip -d bakery.zip /usr/share/nginx/html

sudo systemctl enable nginx
sudo systemctl start nginx
