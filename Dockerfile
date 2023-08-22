FROM ghcr.io/zbwxp/my_docker:ngc-torch2.0.0-cuda12.1.0-py39-gcc9.4.0

#######################################################################################
# Project specific
#######################################################################################
# using packages up-to-date till 22 Aug 2023
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt && pip install -U openmim && mim install 'mmcv>=2.0.0'

USER root
