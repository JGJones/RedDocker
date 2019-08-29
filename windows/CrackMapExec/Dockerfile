FROM ubuntu
LABEL maintainer="JGJones"

# Reference:
# https://github.com/byt3bl33d3r/CrackMapExec/wiki/Installation

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y libssl-dev libffi-dev python-dev build-essential \
	python-pip tmux p7zip-full nmap curl wget git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

USER root

WORKDIR /opt
RUN /bin/bash -l -c "git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec"
WORKDIR CrackMapExec
RUN rm -rf .git
RUN /bin/bash -l -c "pip install -r requirements.txt"
RUN /bin/bash -l -c "python setup.py install"
RUN /bin/bash -l -c "cme -h"
#RUN echo 'alias cme="crackmapexec"' >> ~/.bashrc

# Copy tmux.conf
COPY tmux.conf /root/.tmux.conf

VOLUME /tmp/data

WORKDIR /tmp/data

ENTRYPOINT ["tmux"]