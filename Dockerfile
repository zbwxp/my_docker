FROM ghcr.io/zbwxp/my_docker:ngc-torch2.0.0-cuda12.1.0-py39-gcc9.4.0
ENV FORCE_CUDA="1"
ENV MMCV_WITH_OPS=1
ENV TORCH_CUDA_ARCH_LIST="7.0;7.2;7.5;8.0;8.6;8.7;8.9"
#######################################################################################
# Project specific
#######################################################################################
# using packages up-to-date till 22 Aug 2023
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt && pip install -U openmim ninja && mim install 'mmcv>=2.0.0'

USER root
