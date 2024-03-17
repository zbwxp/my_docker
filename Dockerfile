# Start with a base Python image, lightweight version, compatible with ARM64 architectures
FROM python:3.9-slim

# Set noninteractive mode for apt-get to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Set your working timezone
ENV TZ=Australia/Adelaide
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install basic utilities including byobu for terminal multiplexing
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

# Set locale
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.utf8

# Additional dependencies or setup commands can go here
# For example, to configure git to bypass SSL verification (not recommended for production)
RUN git config --global http.sslverify "false"

# Here you can add the requirements.txt file to your Docker image and install Python dependencies
# COPY requirements.txt /app/
# RUN pip install --no-cache-dir -r /app/requirements.txt

# Alternatively, directly install essential ML libraries as an example
RUN pip install --no-cache-dir \
    matplotlib \
    scikit-learn \
    pandas \
    numpy \
    -r requirements.txt
# Your additional setup could go here
