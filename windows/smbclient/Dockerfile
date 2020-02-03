FROM alpine:3.10

RUN	apk --no-cache add samba-client 
WORKDIR	/tmp

CMD [ "smbclient -h" ]

# docker build -t burstears/smbclient .
# alias smbclient="docker run --rm -it burstears/smbclient smbclient"
# alias nmblookup="docker run --rm -it burstears/smbclient nmblookup"
# alias rpcclient="docker run --rm -it burstears/smbclient rpcclient"
