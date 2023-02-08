# https://hub.docker.com/r/pytorch/pytorch/tags?page=1&name=1.10.0
# this is the base image contains gcc 7.5 and nvcc available
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

RUN git clone https://github.com/facebookresearch/detectron2.git && \
    cd detectron2 && \
    git checkout 932f25a && \
    pip install -e .


