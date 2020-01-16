FROM alpine:latest
LABEL maintainer - JGJ

WORKDIR /opt

RUN apk --no-cache add \
    python2 \
    git &&\
#
# Get Responder
#
	git clone https://github.com/lgandx/Responder.git &&\
	apk del --purge git

# Opening ports for Responder
EXPOSE 21
EXPOSE 25
EXPOSE 53
EXPOSE 80
EXPOSE 110
EXPOSE 137
EXPOSE 138
EXPOSE 139
EXPOSE 389
EXPOSE 445
EXPOSE 587
EXPOSE 1433
EXPOSE 1434
EXPOSE 3128
EXPOSE 3141
EXPOSE 5553

WORKDIR /opt/Responder

ENTRYPOINT [ "./Responder.py" ]

#docker run --rm -it burstears/responder 