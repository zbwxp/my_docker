FROM python:3.9-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Adelaide
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    byobu \
    wget \
    curl \
    ca-certificates \
    ffmpeg \
    libsm6 \
    libxext6 \
    vim \
    locales \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Simplify the locale setting
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN git config --global http.sslverify "false"

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir \
    matplotlib \
    scikit-learn \
    pandas \
    numpy && \
    pip install --no-cache-dir -r requirements.txt