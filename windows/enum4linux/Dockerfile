<<<<<<< HEAD
FROM alpine:3.12
=======
FROM alpine:3.11
>>>>>>> 4f4309a131baf848a078053de17f4fc057d9cd81
LABEL maintainer - JGJ

WORKDIR /tmp

# Temp solution to fix known issue here https://github.com/CiscoCXSecurity/enum4linux/issues/7#issuecomment-585866779
COPY enum4linux.pl /usr/local/bin/enum4linux

#
# enum4linux
#
<<<<<<< HEAD
RUN wget https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py -O /usr/local/bin/polenum.py && \
#    wget https://raw.githubusercontent.com/CiscoCXSecurity/enum4linux/master/enum4linux.pl -O /usr/local/bin/enum4linux && \
    chmod +x /usr/local/bin/polenum.py && \
=======

COPY enum4linux.pl /usr/local/bin/enum4linux

RUN wget https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py > /usr/local/bin/polenum.py && \
#    wget https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl > /usr/local/bin/enum4linux && \
#    wget https://raw.githubusercontent.com/CiscoCXSecurity/enum4linux/master/enum4linux.pl > /usr/local/bin/enum4linux &&\
    chmod +x /usr/local/bin/polenum.py &&\
>>>>>>> 4f4309a131baf848a078053de17f4fc057d9cd81
    chmod +x /usr/local/bin/enum4linux

RUN apk --no-cache add \
    samba \
    dialog \
    openldap-clients \
    python3 \
    perl \
    perl-getopt-long \
    perl-data-dumper &&\
# packages to be removed in clean-up:
    apk add --no-cache --virtual temp \
<<<<<<< HEAD
    py3-setuptools \
    py3-pip \
    gcc \
    python3-dev \
=======
    gcc \
    py2-pip \
    python2-dev \
>>>>>>> 4f4309a131baf848a078053de17f4fc057d9cd81
    libffi-dev \
    openssl-dev \
    musl-dev &&\
#
# Impacket
#
<<<<<<< HEAD
    pip3 install impacket &&\
=======
    pip install impacket &&\
>>>>>>> 4f4309a131baf848a078053de17f4fc057d9cd81
#
# Clean up
#
	apk del temp

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]

# docker build -t burstears/enum4linux .
# alias enum4linux="docker run --rm -it burstears/enum4linux"