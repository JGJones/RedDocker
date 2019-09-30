FROM ubuntu:latest

RUN useradd -c 'smbclient' -m -s /sbin/nologin smbclient
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	smbclient \
	samba-common-bin && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER smbclient
ENTRYPOINT [ "smbclient" ]
CMD [ "-h" ]
