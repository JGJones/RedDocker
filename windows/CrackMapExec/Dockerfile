FROM python:3-alpine
LABEL maintainer="JGJones"

WORKDIR /opt

RUN apk --no-cache add libffi bash openssl file &&\
	apk --no-cache --virtual dev add openssl-dev libffi-dev gcc g++ make git

RUN	git clone --depth=1 --recursive https://github.com/byt3bl33d3r/CrackMapExec &&\
	cd /opt/CrackMapExec &&\
	rm -r .git &&\
	python setup.py install &&\
	cme -h &&\
	apk del dev

VOLUME /tmp/data
WORKDIR /tmp/data
ENV SHELL="/bin/bash"

ENTRYPOINT ["cme"]