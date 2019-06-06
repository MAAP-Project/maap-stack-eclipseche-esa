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

RUN sudo chmod 777 /etc/apt/sources.list
RUN sudo apt-get update

# Installation of pip, gdal, python3, matplotlib, doxyen
# installation of scikit-learn, pandas, geopandas, fiona,  shapely
RUN  sudo apt-get update && \
     sudo apt-get install -y software-properties-common python-software-properties && \
     sudo apt-get install -y python3-lxml && \
     sudo apt-get install -y python3-pip &&\
     sudo pip3 install scipy==0.19.1 && \
     sudo pip3 install matplotlib && \
     sudo pip3 install property && \
     sudo pip install pillow && \
     sudo pip install -U scikit-learn && \
     sudo pip install pandas && \
     sudo git clone https://github.com/geopandas/geopandas.git && \
     cd geopandas && \
     sudo pip install . && \
     cd .. && \
     sudo rm -rf geopandas && \
     sudo apt-get -y install libgdal1-dev && \
     sudo pip install --user fiona && \
     sudo sudo apt-get install python-shapely
     
#INstallation of Octave
RUN  sudo apt-add-repository ppa:octave/stable && \
     sudo apt-get update && \
     sudo apt-get -y install octave && \
     sudo apt-get -y install doxygen  && \
     sudo pip3 install --upgrade pip && \
     sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable && \
     sudo apt update && \
     sudo apt -y upgrade && \
     sudo apt install -y gdal-bin libgdal-dev && \
     sudo pip install requests && \
     sudo pip install conda



# installation of GDL
RUN sudo apt -y install gnudatalanguage

# install gdal and matplotlib with CONDA
#RUN conda install -y gdal matplotlib

RUN sudo pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

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
COPY shareData.sh /usr/bmap/shareData.sh

RUN sudo chmod +x /usr/bmap/initTemplate.sh
RUN sudo chmod +x /usr/bmap/shareAlgorithm.sh
RUN sudo chmod +x /usr/bmap/shareData.sh
ENV PATH="/usr/bmap/:${PATH}"
ENV PYTHONPATH="/usr/bmap/:${PYTHONPATH}"
#We add env variable to request the back end
ENV BMAP_BACKEND_URL=http://backend.biomass-maap.com/bmap-web/

    
    
