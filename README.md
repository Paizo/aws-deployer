# aws-deployer
utility image to process deployments to Amazon AWS EKS via CI/CD pipeline, available at [Docker Hub!](https://hub.docker.com/r/paiz0/aws-deployer/)

[Official AWS Docker in Docker documentation](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker-custom-image.html)

Based on Ubuntu 18.04 with the following additional packages:

 - curl
 - ca-certificates
 - gnupg
 - python=2.7.15
 - python-pip=9.0.1*
 - python-dev=2.7.15*
 - build-essential
 - groff
 - nano
 - git
 - jq
 - apt-transport-https
 - software-properties-common
 - docker-ce=18.06.1*
 - awscli
 - aws-iam-authenticator
 - helm
 
## Prerequisites

There is no escape, running docker in docker needs the [privileged](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) flag, that can be done in the build project:

```json
    "CodeBuildProject": {
      "Properties": {
        "Artifacts": {
          "Type": "CODEPIPELINE"
        },
        "Description": "using docker hub image do deploy",
        "Environment": {
          "ComputeType": "BUILD_GENERAL1_SMALL",
          "Image": "paiz0/aws-deployer:latest",
          "Type": "LINUX_CONTAINER",
          "PrivilegedMode": "true",
```


This image does not automatically starts the docker daemon, in order to use the docker in docker feature the daemon can be started in the install phase of your `buildspec.yml` ie:

```yml
version: 0.2

phases:
  install:
    commands:
      - nohup /usr/bin/dockerd --host=unix:///var/run/docker.sock --host=tcp://127.0.0.1:2375 --storage-driver=overlay > /var/log/dockerd &
      - sleep 15
#you can now pull images within within docker in docker
  build:
    commands:    
      - docker pull imagename:version
```

Alternatively build the image with an entrypoint as shown in the [offical aws repo](https://github.com/aws/aws-codebuild-docker-images/blob/master/ubuntu/docker/17.09.0/dockerd-entrypoint.sh)

