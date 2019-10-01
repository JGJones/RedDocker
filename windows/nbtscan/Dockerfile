FROM alpine:latest
LABEL maintainer="jgjones"

#RUN useradd -c 'nbtscan' -m -s /sbin/nologin nbtscan

#ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     nbtscan && \
#     apt-get --purge autoremove -y && \
# 	apt-get clean && \
#     rm -rf /var/lib/{apt,dpkg,cache,log,lists}

RUN apk update && apk upgrade &&\
	apk add --no-cache nbtscan --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ &&\
	rm -rf /var/cache/apk/*

USER nobody
ENTRYPOINT ["nbtscan"]