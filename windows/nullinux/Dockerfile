FROM python:3-alpine
LABEL maintainer - JGJ

WORKDIR /opt

RUN apk --no-cache add \
    samba-client &&\
#
# Get nullinux
#
	wget https://raw.githubusercontent.com/m8r0wn/nullinux/master/requirements.txt &&\
	wget https://raw.githubusercontent.com/m8r0wn/nullinux/master/nullinux.py &&\
	python3 -m pip install -r requirements.txt

WORKDIR /tmp
ENTRYPOINT [ "python3","/opt/nullinux.py" ]
CMD [ "-h" ]

# docker build -t burstears/nullinux .
# alias nullinux="docker run --rm -it burstears/nullinux"
