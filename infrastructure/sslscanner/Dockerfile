FROM alpine:3.10
MAINTAINER JGJones

# Install git so we can checkout the nassl git repo.
#
# Also install build-base, libffi, libffi-dev, openssl, and
# openssl-dev since they are needed to build some of the dependencies
# of domain-scan.  With the exception of libffi and openssl, these are
# all build dependencies that can be removed at the end.

# Update base
RUN apk update && apk --no-cache upgrade && rm -rf /var/cache/apk/*

# Install sslscan
RUN apk add --no-cache sslscan --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && \
	rm -rf /var/cache/apk/*

WORKDIR /opt

# install sslyze & testssl
RUN	apk --no-cache add \
# Required pkgs for testssl
	drill coreutils curl procps bash \
# Required pkg for sslyze
	python3 &&\
# to be removed after
	apk add --no-cache --virtual temp \
	git build-base \
	libffi-dev openssl-dev \
	linux-headers py3-pip \
	python3-dev perl &&\
#
# sslyze
#
	pip3 install --upgrade setuptools pipenv &&\
	git clone https://github.com/nabla-c0d3/nassl.git &&\
	cd nassl &&\
	pipenv install --dev &&\
	pipenv run invoke build.all &&\
	python3 setup.py install &&\
	cd .. &&\
	rm -rf nassl &&\
	pip3 install sslyze &&\
	rm -rf ~/.cache/* &&\
	rm -rf ~/.share/* &&\
#
# Install testssl.sh
#
	git clone --depth=1 https://github.com/drwetter/testssl.sh.git &&\
	ln -s /opt/testssl.sh/testssl.sh /usr/bin/testssl &&\
#
# Cleanup
#
	apk del temp

USER nobody
CMD [ "/usr/bin/testssl" ]

# alias testssl="docker run --rm -it burstears/sslscanner testssl"
# alias sslscan="docker run --rm -it burstears/sslscanner sslscan"
# alias sslyze="docker run --rm -it burstears/sslscanner sslyze"
