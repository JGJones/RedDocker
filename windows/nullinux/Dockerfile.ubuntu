FROM ubuntu
LABEL maintainer - JGJ

ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -c 'nullinux' -m -s /sbin/nologin nullinux
WORKDIR /home/nullinux

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-setuptools \
    git \
    smbclient \
    ca-certificates && \
#
# Get nullinux
#
	git clone https://github.com/m8r0wn/nullinux.git && \
	cd nullinux && \
	rm -rf .git && \
	bash setup.sh && \
#
# Cleanup
#
	apt --purge -y remove \
	ca-certificates \
	git \
	python3-setuptools \
	python3-pip && \
	apt --purge autoremove -y && \
	apt clean && \
	rm -rf /var/lib/{apt,dpkg,cache,log,lists}

USER nullinux
ENTRYPOINT [ "nullinux" ]
CMD [ "-h" ]