FROM python:3-alpine AS build

ENV VENV="/opt/venv"

RUN	apk add --no-cache \
	git \
    zlib-dev \
    musl-dev \
    libc-dev \
    gcc \
    libffi-dev \
    openssl-dev

WORKDIR /opt

RUN python -m venv $VENV

ENV PATH="$VENV/bin:$PATH"

RUN git clone https://github.com/ShawnDEvans/smbmap.git &&\
	cd smbmap  &&\
	pip install -r requirements.txt  &&\
	rm -Rf .git

RUN wget https://github.com/SecureAuthCorp/impacket/releases/download/impacket_0_9_21/impacket-0.9.21.tar.gz -O tmp.tar.gz &&\
	tar zxf tmp.tar.gz &&\
	mv `ls |grep imp*` impacket &&\
	cd impacket &&\
	pip install -r requirements.txt &&\
	pip install .


FROM python:3-alpine as final

ENV VENV="/opt/venv"
ENV PATH="$VENV/bin:/opt/impacket:/opt/smbmap:$PATH"

COPY --from=build $VENV $VENV
COPY --from=build /opt/smbmap /opt/smbmap
COPY --from=build /opt/impacket/examples /opt/impacket

RUN apk --no-cache add samba-client

#ENTRYPOINT [""]
#CMD ["--help"]
