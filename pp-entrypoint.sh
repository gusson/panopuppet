#!/bin/sh

if [ ! -f /etc/panopuppet/config.yaml ]; then
  echo "ERROR: Configuration file not mounted."
  exit 1
fi

python3 /opt/panopuppet/panopuppet/manage.py makemigrations
sudo -u pano python3 /opt/panopuppet/panopuppet/manage.py migrate

python3 /opt/panopuppet/panopuppet/manage.py collectstatic --noinput

if [ -n "$DEVEL" ]; then
  echo "Development mode detected"
  echo "Adding superuser account with login username/password: pano/puppet"
  echo "from django.contrib.auth.models import User; User.objects.create_superuser('pano', 'admin@example.com', 'puppet')" | python3 /opt/panopuppet/panopuppet/manage.py shell
fi

sudo -u pano python3 /opt/panopuppet/panopuppet/manage.py runserver 0.0.0.0:8000
