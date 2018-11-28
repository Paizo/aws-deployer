FROM ubuntu:18.04

LABEL maintainer="https://github.com/Paizo"

RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update &&\
    apt-get remove docker docker-engine docker.io &&\
    apt-get install --no-install-recommends -y curl=7.58.* \
    ca-certificates=20180409* \
    gnupg=2.2.4* &&\
    #gnupg-l10n \
    #gnupg-utils \
    #gpg \
    #gpgconf &&\
    #apt-get install -y curl gnupg &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&\
    apt-get update &&\
    apt-get install -y python=2.7.15* \
    python-pip=9.0.1* \
    python-dev=2.7.15* \
    build-essential=12.4ubuntu1 \
    groff=1.22.3* \
    nano=2.9.3-2* \
    git=1:2.17* \
    jq=1.5+dfsg-2* \
    apt-transport-https=1.6.3* \
    software-properties-common=0.96.24.32* &&\
    apt-get install -y docker-ce=18.06.1* &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    pip install --upgrade pip==9.0.3 && \
    pip install --upgrade virtualenv && \
    pip install --upgrade awscli &&\
    pip install --upgrade yq &&\
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl &&\
    mv ./kubectl /usr/local/bin &&\
    curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 &&\
    chmod +x aws-iam-authenticator &&\
    mv aws-iam-authenticator /usr/local/bin &&\
    curl -Lo helm-v2.11.0-linux-amd64.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz &&\
    chmod +x helm-v2.11.0-linux-amd64.tar.gz &&\
    tar -zxvf helm-v2.11.0-linux-amd64.tar.gz &&\
    mv linux-amd64/helm /usr/local/bin

