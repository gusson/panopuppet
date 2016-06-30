#!/bin/sh

sudo docker build -t panopuppet_devel .
sudo docker run -v $(pwd)/config:/etc/panopuppet -p 8080:8080 -e "DEVEL=true" -it --rm panopuppet_devel
sudo docker rmi panopuppet_devel
