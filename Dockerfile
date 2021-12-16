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
        unzip \
        ssh \
        tcpflow \
        vim

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O /opt/awscliv2.zip \
    && unzip -d /opt /opt/awscliv2.zip \
    && /opt/aws/install \
    && rm /opt/awscliv2.zip \
    && wget https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && wget https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz -O /tmp/helm.tar.gz \
    && cd /tmp \
    && tar xzvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && wget -O /tmp/jamal.gz https://github.com/quantumew/jamal/releases/download/v1.0.1/jamal-Linux-arm64.tar.gz \
    && tar -xvzf /tmp/jamal.gz -C /usr/bin jamal \
    && chmod a+x /usr/local/bin/kubectl /usr/local/bin/helm /usr/local/bin/jamal \
    && curl -o /tmp/mongo.tgz https://downloads.mongodb.com/compass/mongosh-0.7.7-linux.tgz \
    && tar -xvzf /tmp/mongo.tgz -C /usr/local bin/mongosh

RUN rm -rf /var/lib/apt/lists/*
