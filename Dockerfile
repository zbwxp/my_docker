# https://hub.docker.com/r/pytorch/pytorch/tags?page=1&name=1.10.0
# this is the base image contains gcc 7.5 and nvcc available
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

# Install ubuntu packages
RUN apt-get update && \
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

RUN git clone https://github.com/facebookresearch/detectron2.git && \
    cd detectron2 && \
    git checkout 932f25a && \
    pip install -e .


