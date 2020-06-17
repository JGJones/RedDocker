FROM alpine:3.11
LABEL maintainer - JGJ

WORKDIR /tmp

#
# enum4linux
#

COPY enum4linux.pl /usr/local/bin/enum4linux

RUN wget https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py > /usr/local/bin/polenum.py && \
#    wget https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl > /usr/local/bin/enum4linux && \
#    wget https://raw.githubusercontent.com/CiscoCXSecurity/enum4linux/master/enum4linux.pl > /usr/local/bin/enum4linux &&\
    chmod +x /usr/local/bin/polenum.py &&\
    chmod +x /usr/local/bin/enum4linux

RUN apk --no-cache add \
    samba \
    dialog \
    openldap-clients \
    python2 \
    perl \
    perl-getopt-long \
    perl-data-dumper &&\
# packages to be removed in clean-up:
    apk add --no-cache --virtual temp \
    gcc \
    py2-pip \
    python2-dev \
    libffi-dev \
    openssl-dev \
    musl-dev &&\
#
# Impacket
#
    pip install impacket &&\
#
# Clean up
#
	apk del temp

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]

# docker build -t burstears/enum4linux .
# alias enum4linux="docker run --rm -it burstears/enum4linux"