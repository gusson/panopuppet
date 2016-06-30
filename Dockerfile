FROM debian:jessie

WORKDIR /opt/panopuppet
VOLUME /etc/panopuppet
EXPOSE 8000

RUN apt-get update && apt-get install -y gcc make python3 python3-dev cyrus-sasl2-dbg libsasl2-dev python3-arrow python3-requests python3-pip libldap2-dev python-setuptools python-dev libsasl2-dev sudo

ADD . /opt/panopuppet

RUN pip3 install -r /opt/panopuppet/requirements.txt && python3 /opt/panopuppet/setup.py install

RUN useradd --uid 500  --home-dir /opt/panopuppet pano
RUN chown -R pano /opt/panopuppet && mkdir /srv/staticfiles && chown -R pano /srv/staticfiles

CMD ["/opt/panopuppet/pp-entrypoint.sh"]

