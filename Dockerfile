FROM fedora:22
MAINTAINER Patrice FERLET <metal3d@gmail.com>

ENV NUMWORKER 4
EXPOSE 8000

RUN dnf install -y python-pip python-qt4 Xvfb which xorg-x11-fonts-100dpi && dnf clean all
RUN pip install Ghost.py gunicorn

COPY belphegor/main.py /opt/main.py
WORKDIR /opt
CMD xvfb-run gunicorn -w $NUMWORKER -b 0.0.0.0:8000 main:app




