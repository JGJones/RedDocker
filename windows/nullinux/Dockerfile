FROM alpine:latest
LABEL maintainer - JGJ

WORKDIR /opt

RUN apk --no-cache add \
    python3 \
    samba-client &&\
#
# Get nullinux
#
	wget https://raw.githubusercontent.com/m8r0wn/nullinux/master/requirements.txt &&\
	wget https://raw.githubusercontent.com/m8r0wn/nullinux/master/nullinux.py &&\
	python3 -m pip install -r requirements.txt

USER nobody
ENTRYPOINT [ "python3","/opt/nullinux.py" ]
CMD [ "-h" ]

# docker build -t burstears/nullinux .
# alias nullinux="docker run --rm -it burstears/nullinux"