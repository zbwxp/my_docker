FROM --platform=linux/arm64/v8 ubuntu:latest

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3-pip


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