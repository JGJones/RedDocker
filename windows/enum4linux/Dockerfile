FROM ubuntu:latest
LABEL maintainer - JGJ

# TODO? RUN useradd -c 'enum4linux' -m -s /sbin/nologin enum4linux

WORKDIR /tmp

ARG DEBIAN_FRONTEND=noninteractive

# Using a single RUN to keep size small

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    smbclient \
    samba-common-bin \
    dialog \
    ldap-utils \
    libgetopt-complete-perl \
    libdata-dumper-simple-perl \
# packages to be removed in clean-up below:
    wget \
    python-setuptools \
    git \
    ca-certificates && \
#
# Impacket
#
    git clone https://github.com/SecureAuthCorp/impacket.git && \
	/bin/bash -l -c "cd impacket && python setup.py install" && \
	rm -rf /tmp/impacket && \
#
# enum4linux
#
	wget https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py -O /usr/local/bin/polenum.py && \
	wget https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl -O /usr/local/bin/enum4linux && \
	chmod +x /usr/local/bin/polenum.py && \
	chmod +x /usr/local/bin/enum4linux && \
#
# Clean up
#
	apt-get --purge remove ca-certificates wget git python-setuptools -y && \
	apt-get --purge autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

#USER enum4linux
ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]