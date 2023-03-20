FROM ghcr.io/zbwxp/my_docker:torch1.13.1-cuda11.7-py39-gcc9.4.0

#######################################################################################
# Project specific
#######################################################################################
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt && pip install -U openmim && mim install 'mmcv==2.0.0rc4'

USER root
