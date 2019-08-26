#   Capgemini for Biomass project
#   Author CBall
#   Date first created 27/03/2019
FROM ubuntu:16.04

LABEL maintainer="caroline.ball@capgemini.com"
LABEL version="1.0"
LABEL description="Docker file based on ubuntu for python algorithms for Biomass project"

#INSTALL GDAL
RUN apt-get update &&\
    echo "deb http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial main" >> /etc/apt/sources.list &&\
    echo "deb-src http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial main" >> /etc/apt/sources.list &&\
    apt-get install -y software-properties-common python-software-properties &&\
    add-apt-repository ppa:ubuntugis/ppa &&\
    apt-get update &&\
    apt-get install -y gdal-bin python3-gdal 

#UPGRADE PIP
RUN apt-get update && apt-get install -y --reinstall python3-pip && \
        apt-get -y install libsm6 libxext6 libxrender-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

#ADD SCRIPT FILES
COPY ./scripts /usr/bmap/
COPY ./requirements.txt /usr/bmap/requirements.txt

#INSTALL REQUIRES LIBRAIRIES 
#RUN apt-get install -y python3-lxml
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install -r /usr/bmap/requirements.txt

# Add Librairies for RestClient.py
RUN pip install requests

ENV PATH="/usr/bmap/:${PATH}"
ENV PYTHONPATH="/usr/bmap/:${PYTHONPATH}"
ENV BMAP_BACKEND_URL=http://backend-val.biomass-maap.com/bmap-web/

# TEST IMPORT GDAL
CMD ["python3"]
