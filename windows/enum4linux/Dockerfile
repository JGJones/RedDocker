FROM ubuntu
LABEL maintainer - JGJ

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y smbclient ldap-utils wget && \
	rm -rf /var/lib/apt/lists/*

USER root

# Polenum.py - https://github.com/Wh1t3Fox/polenum

RUN wget https://raw.githubusercontent.com/portcullislabs/enum4linux/master/enum4linux.pl -o /usr/local/bin/enum4linux
RUN chmod +x /usr/local/bin/enum4linux

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]