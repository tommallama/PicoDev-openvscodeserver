# This template is in part from https://github.com/gitpod-io/openvscode-releases check back there and update this file as needed.
FROM ubuntu:20.04

# Need a gitpod-io/openvscode-server/ target release here
# i.e. openvscode-server-v1.61.0 OR openvscode-server-v1.60.2
ARG RELEASE_TAG=openvscode-server-v1.61.0

ARG USERNAME=openvscode-server
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt update && \
    apt install -y git wget sudo && \
    rm -rf /var/lib/apt/lists/*

# Pico required tools
ENV TZ=America/New_York
RUN apt update && apt install --no-install-recommends -y \
    cmake \ 
    build-essential \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    python3 \
    && alias python=python3 \
    && rm -rf /var/lib/apt/lists/* 
    
WORKDIR /home/

# Downloading the latest VSC Server release and extracting the release archive
RUN wget https://github.com/gitpod-io/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-x64.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-x64.tar.gz && \
    rm -f ${RELEASE_TAG}-linux-x64.tar.gz
   
# Creating the user and usergroup
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USERNAME -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN chmod g+rw /home && \
    mkdir -p /home/workspace && \
    chown -R $USERNAME:$USERNAME /home/workspace && \
    chown -R $USERNAME:$USERNAME /home/${RELEASE_TAG}-linux-x64;
    
USER $USERNAME

WORKDIR /home/workspace/

ENV PICO_SDK_PATH=/home/workspace/picotools/pico-sdk
ENV PICO_EXAMPLES_PATH=/home/workspace/picotools/pico-examples
ENV PICO_EXTRAS_PATH=/home/workspace/picotools/pico-extras
ENV PICO_PLAYGROUND_PATH=/home/workspace/picotools/pico-playground

ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV HOME=/home/workspace
ENV EDITOR=code
ENV VISUAL=code
ENV GIT_EDITOR="code --wait"
ENV OPENVSCODE_SERVER_ROOT=/home/${RELEASE_TAG}-linux-x64

EXPOSE 3000

ENTRYPOINT ${OPENVSCODE_SERVER_ROOT}/server.sh
