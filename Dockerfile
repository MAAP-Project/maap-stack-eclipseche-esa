# Copyright (c) 2012-2018 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Capgemini modified the first verion of this dockerfile
# for Biomass Project
# Contributors:
#   Red Hat, Inc. - initial API and implementation
#   Capgemini for Biomass project

FROM eclipse/ubuntu_python

LABEL maintainer="teddy.kossoko@capgemini.com"
LABEL version="1.0"
LABEL description="Docker file based on ubuntu for eclipse-che workspaces for Biomass project"

USER root
#RUN  chmod 777 /etc/apt/sources.list
RUN  apt-get update

# Installation of pip, gdal, python3, matplotlib, doxyen
# installation of scikit-learn, pandas, geopandas, fiona,  shapely
RUN  apt-get update && \
      apt-get install -y software-properties-common python-software-properties python3-lxml python3-pip &&\
      pip3 install scipy==0.19.1 && \
      pip3 install matplotlib && \
      pip3 install property && \
      pip install pillow && \
      pip install -U scikit-learn && \
      pip install pandas && \
      git clone https://github.com/geopandas/geopandas.git && \
     cd geopandas && \
      pip install . && \
     cd .. && \
      rm -rf geopandas && \
      apt-get -y install libgdal1-dev && \
      pip install --user fiona && \
       apt-get install python-shapely 
     
#INstallation of Octave
RUN   apt-add-repository ppa:octave/stable && \
      apt-get update && \
      apt-get -y install octave && \
      apt-get -y install doxygen  && \
      pip3 install --upgrade pip && \
      add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable && \
      apt update && \
      apt -y upgrade && \
      apt install -y gdal-bin libgdal-dev && \
      pip install requests && \
      pip install conda 


# installation of GDL
RUN  apt -y install gnudatalanguage

# install gdal and matplotlib with CONDA
#RUN conda install -y gdal matplotlib

RUN  pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

# We add the script folder and the zip file to be able to unzip the structure of the project
COPY initTemplate.sh /usr/bmap/initTemplate.sh
COPY initCredentials.sh /usr/bmap/initCredentials.sh
COPY Project_template.zip /usr/bmap/Project_template.zip
COPY shareAlgorithm.sh /usr/bmap/shareAlgorithm.sh
COPY .gitlab-ci.yml /usr/bmap/.gitlab-ci.yml


# We add the RestClient file
COPY RestClient.py /usr/bmap/RestClient.py
COPY quicklook_raster.py /usr/bmap/quicklook_raster.py
COPY ingestData.py /usr/bmap/ingestData.py
COPY ingestData.sh /usr/bmap/ingestData.sh

RUN  chmod +x /usr/bmap/initTemplate.sh
RUN  chmod +x /usr/bmap/shareAlgorithm.sh
RUN  chmod +x /usr/bmap/ingestData.sh
ENV PATH="/usr/bmap/:${PATH}"
ENV PYTHONPATH="/usr/bmap/:${PYTHONPATH}"
#We add env variable to request the back end
ENV BMAP_BACKEND_URL=http://backend-val.biomass-maap.com/bmap-web/

USER user
    
    
