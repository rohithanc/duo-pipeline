#! /bin/bash

ssh -i /home/rohithan9615/.ssh/id_rsa rohithan9615@34.105.135.86 << EOF
sudo docker pull rohithan9615/flask-app:1.0
sudo docker run -d -p 5000:5000 --name flask-app rohithan9615/flask-app:1.0
git clone https://github.com/rohithan/duo-pipeline.git
sudo docker run -d -p 80:80 --mount type=bind, source=./duo-task/nginx.conf --name nginx nginx:latest
EOF
