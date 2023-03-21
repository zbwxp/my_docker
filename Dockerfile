ARG UBUNTU_VERSION=20.04
ARG CUDA_VERSION=11.7.1
# gcc 9.4.0
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu${UBUNTU_VERSION}
# assign your miniconda3 version https://docs.conda.io/en/latest/miniconda.html
ARG MINICONDA=Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
# assign your nvcc version https://anaconda.org/conda-forge/cudatoolkit-dev/files?page=2
ARG CUDA_VERSION=11.6

# Install ubuntu packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        git \
        byobu \
        zip \
        wget \
        curl \
        ca-certificates \
        locales \
        openssh-server \
        ffmpeg \
        libsm6 \
        libxext6 \
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
# Install miniconda (python)
# Referenced PyTorch's Dockerfile:
#   https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/${MINICONDA} && \
    chmod +x miniconda.sh && \
    ./miniconda.sh -b -p conda && \
    rm miniconda.sh 
ENV PATH $HOME/conda/bin:$PATH
RUN touch $HOME/.bashrc && \
    echo "export PATH=$HOME/conda/bin:$PATH" >> $HOME/.bashrc && \
    conda init bash
# RUN conda create --name proj python=3.9 -y
# SHELL ["conda", "run", "-n", "proj", "/bin/bash", "-c"]
# command from pytorch.org
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.6 -c pytorch -c conda-forge
RUN conda clean -ya
RUN conda install -c conda-forge cudatoolkit-dev=${CUDA_VERSION}  -y
RUN conda create --name openmmlab python=3.8 -y
RUN conda init bash
RUN echo "conda activate openmmlab" > ~/.bashrc
RUN conda install pytorch torchvision -c pytorch
RUN pip install -U openmim
RUN mim install mmcv-full
RUN git clone https://github.com/open-mmlab/mmdetection.git
WORKDIR $HOME/mmdetection
RUN pip install -r requirements/build.txt
RUN pip install -v -e .

#######################################################################################
# Project specific
#######################################################################################
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt

# Start openssh server
USER root