#! /bin/bash

ls -la /var/lib/jenkins/.ssh/

ssh -tt -i /var/lib/jenkins/.ssh/id_rsa rohithan9615@35.192.34.70 << EOF
if ! [ $(docker network ls | grep duo-task-network) ]; then
  sudo docker network create duo-task-network
fi
sudo docker pull rohithan9615/flask-app:1.0
if [ $(docker ps -a | grep flask-app) ]; then
  sudo docker rm -f flask-app
fi
sudo docker run -d -p 5000:5000 --name flask-app --network duo-task-network rohithan9615/flask-app:1.0
if [ -d duo-task ]; then
  rm -rf duo-task
fi
git clone https://github.com/rohithanc/duo-pipeline
if [ $(docker ps -a | grep nginx) ]; then
  sudo docker rm -f nginx
fi
sudo docker run -d -p 80:80 --mount type=bind,source=/home/rohithan9615/duo-pipeline/nginx.conf,target=/etc/nginx/nginx.conf --network duo-task-network --name nginx nginx:latest
EOF
