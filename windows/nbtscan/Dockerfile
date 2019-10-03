FROM alpine:latest
LABEL maintainer="jgjones"

RUN apk update && apk upgrade &&\
	apk add --no-cache nbtscan --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ &&\
	rm -rf /var/cache/apk/*

USER nobody
ENTRYPOINT ["nbtscan"]