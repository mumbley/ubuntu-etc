FROM ubuntu

MAINTAINER Steve Gall <steve.gall@me.com>

ENV helmVersion "2.11.0"
ENV kubectlVersion "1.15.0"
ENV jamalVersion "1.0.0"

RUN apt-get update
RUN apt-get install -y \
        curl \
        wget \
        dnsutils \
        htop \
        jq \
        lsof \
        netcat \
        nmap \
        python-pip \
        ssh \
        tcpflow \
        vim \
        && \
        pip install awscli

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 -O /usr/local/bin/dumb-init \
    && wget https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz -O /tmp/helm.tar.gz \
    && cd /tmp \
    && tar xzvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && wget https://github.com/quantumew/jamal/releases/download/v1.0.0/jamal-v1.0.0.tar.gz -O /tmp/jamal.tar.gz \
    && tar xzvf jamal.tar.gz \
    && mv jamal-*/linux/amd64/jamal /usr/local/bin \
    && chmod a+x /usr/local/bin/kubectl /usr/local/bin/dumb-init /usr/local/bin/helm /usr/local/bin/jamal

RUN rm -rf /var/lib/apt/lists/*
