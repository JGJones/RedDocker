FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.30

ENV PATH=$PATH:/opt/odat

WORKDIR /opt
RUN	wget https://github.com/quentinhardy/odat/releases/download/4.1/odat-linux-libc2.12-x86_64.tar.gz &&\
	tar xf odat-linux-libc2.12-x86_64.tar.gz &&\
	mv odat-libc2.12-x86_64 odat &&\
	adduser odat -D -s /sbin/nologin &&\
	chown odat -R /opt/odat &&\
	rm odat-linux-libc2.12-x86_64.tar.gz &&\
	ln -s /opt/odat/odat-libc2.12-x86_64 /opt/odat/odat

WORKDIR /opt/odat
USER odat
ENTRYPOINT ["odat"]
CMD ["--help"]
