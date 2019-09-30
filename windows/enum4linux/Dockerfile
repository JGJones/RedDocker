FROM alpine:latest
LABEL maintainer - JGJ

#RUN useradd -c 'enum4linux' -m -s /sbin/nologin enum4linux

WORKDIR /tmp

# Using a single RUN to keep size small

RUN apk update && \
    apk upgrade && \
    apk add \
    samba \
    dialog \
    openldap-clients \
    python2 \
    perl \
    perl-getopt-long \
    perl-data-dumper \
# packages to be removed in clean-up below:
    py2-setuptools \
    git \
    curl \
    build-base \
    python2-dev \
    libffi-dev \
    openssl-dev \
    ca-certificates && \
#
# Impacket
#
    git clone https://github.com/SecureAuthCorp/impacket.git && \
	cd impacket && python setup.py install && \
	rm -rf /tmp/impacket && \
#
# enum4linux
#
	curl https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py > /usr/local/bin/polenum.py && \
	curl https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl > /usr/local/bin/enum4linux && \
	chmod +x /usr/local/bin/polenum.py && \
	chmod +x /usr/local/bin/enum4linux && \
#
# Clean up
#
	apk del \
    py2-setuptools \
    git \
    curl \
    build-base \
    python2-dev \
    libffi-dev \
    openssl-dev \
    ca-certificates && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]