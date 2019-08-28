FROM kalilinux/kali-linux-docker
LABEL maintainer - JGJ

RUN apt update && \
    apt install -y python3 python3-pip git smbclient && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/m8r0wn/nullinux.git

WORKDIR /opt/nullinux

RUN ./setup.sh

ENTRYPOINT [ "nullinux" ]
CMD [ "-h" ]