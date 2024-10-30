FROM ubuntu

MAINTAINER Steve Gall <steve.gall@me.com>

ENV kubectlVersion "1.29.2"
ENV jamalVersion "1.0.1"

RUN apt-get update
RUN apt-get install -y \
        curl \
        wget \
        dnsutils \
        htop \
        jq \
        lsof \
        netcat-traditional \
        nmap \
        unzip \
        ssh \
        tcpflow \
        rclone \
        sysstat \
        vim

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip 
RUN  wget https://storage.googleapis.com/kubernetes-release/release/v1.29.2/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && wget -O /tmp/jamal.gz https://github.com/quantumew/jamal/releases/download/v1.0.1/jamal-Linux-arm64.tar.gz \
    && cd /tmp \
    && tar -xvzf /tmp/jamal.gz -C /usr/local/bin jamal \
    && rm -f /tmp/jamal.gz \
    && chmod a+x /usr/local/bin/kubectl /usr/local/bin/jamal 
RUN rm -rf /var/lib/apt/lists/*
