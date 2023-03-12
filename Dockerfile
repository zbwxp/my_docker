FROM ghcr.io/zbwxp/my_docker:torch1.10.1-cuda11.3-py39-gcc9.4.0

#######################################################################################
# Project specific
#######################################################################################
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

USER root