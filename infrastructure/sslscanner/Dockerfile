FROM ubuntu:18.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV VENV=/opt/venv

WORKDIR /opt

RUN apt update && apt install --no-install-recommends -y \
	build-essential \
	python3 \
	python3-pip \
	python3-wheel \
	python3-setuptools \
	python3-virtualenv \
	git \
	zlib1g-dev &&\
#
# openssl with SSLv2/SSLv3 support
#
	git clone https://github.com/PeterMosmans/openssl.git &&\
	cd openssl &&\
	./config zlib-dynamic &&\
	make depend &&\
	make install &&\
	cd .. &&\
#
# sslscan & testssl.sh	
#
	git clone https://github.com/rbsec/sslscan.git &&\
	cd sslscan &&\
	make && make install &&\
	cd .. &&\
	git clone --depth 1 https://github.com/drwetter/testssl.sh.git &&\
	rm -r testssl.sh/.git &&\
#
# SSLYZE
#
	python3 -m virtualenv --python=/usr/bin/python3 $VENV &&\
	export PATH="$VENV/bin:$PATH" &&\
	pip3 install sslyze

FROM ubuntu:18.04

ENV VENV=/opt/venv
ENV PATH="$VENV/bin:/usr/local/ssl/bin:/opt/testssl.sh:/opt/sslscan:$PATH"
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /opt

COPY --from=build /usr/local/ssl /usr/local/ssl
COPY --from=build /opt/sslscan /opt/sslscan
COPY --from=build /opt/testssl.sh /opt/testssl.sh
COPY --from=build $VENV $VENV

RUN apt update && apt install --no-install-recommends -y \
	bsdmainutils \
	python3 \
	unattended-upgrades &&\
	unattended-upgrade -d &&\
	apt purge unattended-upgrades -y &&\
	apt --purge autoremove -y &&\
	rm -rf /var/lib/apt/*
