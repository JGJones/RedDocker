FROM alpine:3.11
LABEL maintainer="jgjones"

RUN apk add --no-cache nbtscan --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ 

USER nobody
ENTRYPOINT ["nbtscan"]
CMD ["-h"]
