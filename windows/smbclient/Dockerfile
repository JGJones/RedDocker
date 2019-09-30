FROM alpine:latest

#RUN adduser -D -s /sbin/nologin smbclient
RUN	apk update && \
	apk upgrade && \
	apk add samba-client && \
	rm -rf /var/cache/apk/*

#USER smbclient
ENTRYPOINT [ "smbclient" ]
CMD [ "-h" ]
