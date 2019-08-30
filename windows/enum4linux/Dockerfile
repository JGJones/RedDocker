FROM ubuntu
LABEL maintainer - JGJ

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y smbclient git ldap-utils wget libgetopt-complete-perl unzip python-setuptools && \
	rm -rf /var/lib/apt/lists/*

USER root

# Impacket 

WORKDIR /tmp
RUN git clone https://github.com/SecureAuthCorp/impacket.git && \
	/bin/bash -l -c "cd impacket && python setup.py install" && \
	rm -rf /tmp/impacket

# Enum4Linux

RUN wget https://raw.githubusercontent.com/Wh1t3Fox/polenum/master/polenum.py -O /usr/local/bin/polenum.py && \
	wget https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl -O /usr/local/bin/enum4linux && \
	chmod +x /usr/local/bin/polenum.py && \
	chmod +x /usr/local/bin/enum4linux

RUN apt-get --purge remove wget unzip git python-setuptools -y && \
	apt-get --purge autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]