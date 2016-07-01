#!/bin/sh

sudo docker build -t panopuppet_devel .
udo docker run -v $(pwd)/config:/etc/panopuppet -p 8000:8000 -e "DEVEL=true" -it --rm panopuppet_devel
echo "Cleaning up container..."
sudo docker rmi panopuppet_devel
