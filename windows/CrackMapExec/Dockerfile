FROM ubuntu
LABEL maintainer="JGJones"

# Reference:
# https://github.com/byt3bl33d3r/CrackMapExec/wiki/Installation

USER root
WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y \
	#--no-install-recommends \
	libssl-dev \
	libffi-dev \
	python-dev \
	python-pkg-resources \
	python-cryptography \
	tmux \
# packages to be removed in clean-up below:
	python-pip \
	python-setuptools \
	build-essential \
	ca-certificates \
	git && \
#
# CrackMapExec
#
	/bin/bash -l -c "git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec" && \
	rm -rf CrackMapExec/.git && \
	/bin/bash -l -c "cd CrackMapExec && pip install -r requirements.txt && python setup.py install && cme -h" && \
#	/bin/bash -l -c "pip install -r requirements.txt" && \
#	/bin/bash -l -c "python setup.py install" && \
#	/bin/bash -l -c "cme -h" && \
#
# Clean up
#
	apt-get --purge remove ca-certificates build-essential python-setuptools python-pip git -y && \
	apt-get --purge autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/{apt,dpkg,cache,log,lists}

# Copy tmux.conf
COPY tmux.conf /root/.tmux.conf

VOLUME /tmp/data

WORKDIR /tmp/data

ENTRYPOINT ["tmux"]