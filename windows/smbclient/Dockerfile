FROM alpine:latest

RUN	apk --no-cache add samba-client 

CMD [ "smbclient -h" ]

# docker build -t burstears/smbclient .
# alias smbclient="docker run --rm -it burstears/smbclient smbclient"
# alias nmblookup="docker run --rm -it burstears/smbclient nmblookup"
# alias rpcclient="docker run --rm -it burstears/smbclient rpcclient"