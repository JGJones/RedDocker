FROM alpine:latest
LABEL maintainer - JGJ

#RUN useradd -c 'nullinux' -m -s /sbin/nologin nullinux
WORKDIR /opt

RUN apk update && \
	apk upgrade && \
    apk add \
    python3 \
    py3-setuptools \
    git \
    samba-client && \
#
# Get nullinux
#
	git clone https://github.com/m8r0wn/nullinux.git && \
	cd nullinux && \
	rm -rf .git && \
	pip3 install -r requirements.txt && \
#
# Cleanup
#
	apk del py3-setuptools ca-certificates libcurl git && \
	rm -rf /var/cache/apk/*

ENTRYPOINT [ "/opt/nullinux/nullinux.py" ]
CMD [ "-h" ]