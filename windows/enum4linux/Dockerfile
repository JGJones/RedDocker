FROM kalilinux/kali-linux-docker
LABEL maintainer - JGJ

RUN apt update && \
    apt install -y enum4linux && \
	rm -rf /var/lib/apt/lists/*

USER root

ENTRYPOINT [ "enum4linux" ]
CMD [ "-h" ]