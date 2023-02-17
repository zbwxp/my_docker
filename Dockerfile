FROM alpine:latest
LABEL MAINTAINER="bz"

ENV CONDA_VERSION latest
ENV PYTHONDONTWRITEBYTECODE=true


RUN apk add --no-cache wget bzip2 \
    && addgroup -S anaconda \
    && adduser -D -u 10151 anaconda -G anaconda \
    && wget --quiet https://repo.continuum.io/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh \
    && mv Miniconda3-$CONDA_VERSION-Linux-x86_64.sh miniconda.sh \
    && sh ./miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/anaconda/.profile \
    && echo "conda activate base" >> /home/anaconda/.profile \
    && /opt/conda/bin/conda install --freeze-installed tini -y \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && /opt/conda/bin/conda clean -afy \
    && chown -R anaconda:anaconda /opt/conda \
    && apk del wget bzip2

USER anaconda:anaconda
WORKDIR /home/anaconda/

# Setup timezone
ENV TZ=Australia/Adelaide
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

####################################################################################
# START USER SPECIFIC COMMANDS
####################################################################################

# Stage 1

# RUN pip install mmcv-full==1.4.4 mmsegmentation==0.24.0 scipy timm matplotlib

# Stage 2 copy the req.txt from outside world into docker image

# COPY requirements.txt requirements.txt

# RUN pip install -r requirements.txt && \
#     pip install pycocotools && \
#     pip install git+https://github.com/cocodataset/panopticapi.git





