# https://hub.docker.com/r/pytorch/pytorch/tags?page=1&name=1.10.0
# this is the base image contains gcc 7.5 and nvcc available
ARG d2_commit=932f25a
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

# Install ubuntu packages
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        curl \
        ca-certificates \
        sudo \
        locales \
        openssh-server \
        vim && \
    # Remove the effect of `apt-get update`
    rm -rf /var/lib/apt/lists/* && \
    # Make the "en_US.UTF-8" locale
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Setup timezone
ENV TZ=Australia/Adelaide
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

####################################################################################
# START USER SPECIFIC COMMANDS
####################################################################################
ENV GITHUB_TOKEN=592599+56298950622951

# Stage 1

RUN pip install mmcv-full==1.4.4 mmsegmentation==0.24.0 scipy timm matplotlib

# Stage 2 copy the req.txt from outside world into docker image

# COPY requirements.txt requirements.txt

# RUN pip install -r requirements.txt && \
#     pip install pycocotools && \
#     pip install git+https://github.com/cocodataset/panopticapi.git





