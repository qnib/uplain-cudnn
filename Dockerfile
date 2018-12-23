ARG DOCKER_REGISTRY="docker.io"
ARG FROM_IMG_REPO="qnib"
ARG FROM_IMG_NAME="uplain-cuda"
ARG FROM_IMG_TAG="2018-12-23.2"
# Use plain ubuntu to download cudnn
FROM ubuntu AS build

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

ARG CUDNN_VER=v7.4.1.5
ARG CUDA_VER=10.0
ARG CUDNN_URL=http://people.cs.uchicago.edu/~kauffman/nvidia/cudnn/
RUN apt-get update \
 && apt-get install -y wget \
 && mkdir -p /usr/local/cuda/ \
 && wget -qO - ${CUDNN_URL}/cudnn-${CUDA_VER}-linux-x64-${CUDNN_VER}.tgz |tar xfz - -C /usr/local/cuda/ --strip-components=1

FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}
COPY --from=build /usr/local/cuda/ /usr/local/cuda/
