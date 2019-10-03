FROM python:2-alpine AS builder
LABEL maintainer="JGJones"

ENV VIRTUAL_ENV="/opt/venv"
ENV JOHN="/opt/JohnTheRipper"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk --no-cache add \
    git \
    python2-dev \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    openldap-dev \
    cyrus-sasl-dev \
    libffi-dev \
    openssl-dev \
    perl \
	build-base 
#	bash 

WORKDIR /opt
RUN pip install virtualenv && virtualenv $VIRTUAL_ENV

# Impacket 

RUN git clone https://github.com/SecureAuthCorp/impacket.git &&\
	cd impacket &&\
	python setup.py install

# RedSnarf (using rmdavy's forked version as more up to date)

RUN pip install ipy \
	netaddr \
	requests \
	pyopenssl \
	termcolor \
	python-ldap \
	pysmb \
	docopt \
	pyuserinput \
	wget \
	pywinrm \
	pycrypto


RUN git clone https://github.com/savon-noir/python-libnmap.git &&\
	git clone https://github.com/magnumripper/JohnTheRipper.git


	# git clone https://github.com/byt3bl33d3r/pth-toolkit.git && \
	# git clone https://github.com/Neohapsis/creddump7 && \

COPY redsnarf /opt/redsnarf

RUN cd python-libnmap && python setup.py install

RUN cd $JOHN/src && ./configure CFLAGS="-g -O2 -mno-avx2" && make clean && make -s
RUN apk add bash
RUN mkdir /etc/bash_completion.d
RUN cd redsnarf && python redsnarf.py --auto_complete install

#ENV PATH=$PATH:/opt/redsnarf

#ENTRYPOINT [ "sh" ]
#CMD [ "-h" ]

FROM python:2-alpine
LABEL maintainer="JGJones"

ENV VIRTUAL_ENV="/opt/venv"
ENV JOHN="/opt/JohnTheRipper"
ENV PATH="$VIRTUAL_ENV/bin:$PATH:/opt/redsnarf:$JOHN/run"

COPY --from=builder $VIRTUAL_ENV $VIRTUAL_ENV
COPY --from=builder $JOHN/run $JOHN/run
COPY --from=builder /etc/bash_completion.d /etc/bash_completion
COPY pth-toolkit /opt/pth-toolkit
COPY creddump7 /opt/creddump7
COPY redsnarf /opt/redsnarf

RUN chmod +x /opt/redsnarf/redsnarf.py

RUN apk --no-cache add \
	libldap \
	libffi \
	libxslt \
	libxml2 \
	libgomp


VOLUME /tmp/data
#WORKDIR /tmp/data
ENTRYPOINT ["python", "/opt/redsnarf/redsnarf.py"]
CMD ["--help"]