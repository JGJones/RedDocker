FROM ubuntu
LABEL maintainer="JGJones"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git python-setuptools python-pip \
    python-ipy python2.7-dev libpq-dev python-dev libxml2-dev \
    libxslt1-dev libldap2-dev libsasl2-dev libffi-dev libssl-dev \
    build-essential --fix-missing && \
	rm -rf /var/lib/apt/lists/*

USER root
COPY tmux.conf /root/.tmux.conf
# Impacket 

WORKDIR /tmp
RUN git clone https://github.com/SecureAuthCorp/impacket.git && \
	/bin/bash -l -c "cd impacket && python setup.py install" && \
	rm -rf /tmp/impacket

# RedSnarf (using rmdavy's forked version as more up to date)

WORKDIR /opt

RUN git clone https://github.com/byt3bl33d3r/pth-toolkit.git && \
	git clone https://github.com/Neohapsis/creddump7 && \
	git clone https://github.com/savon-noir/python-libnmap.git && \
	git clone https://github.com/magnumripper/JohnTheRipper.git && \
	git clone https://github.com/rmdavy/redtest.git redsnarf

RUN /bin/bash -l -c "pip install netaddr" && \
	/bin/bash -l -c "pip install termcolor" && \
	/bin/bash -l -c "pip install python-ldap" && \
	/bin/bash -l -c "pip install pysmb" && \
	/bin/bash -l -c "pip install docopt" && \
	/bin/bash -l -c "pip install pyuserinput" && \
	/bin/bash -l -c "pip install wget" && \
	/bin/bash -l -c "pip install pywinrm"

RUN /bin/bash -l -c "cd python-libnmap && python setup.py install"

RUN /bin/bash -l -c "cd JohnTheRipper/src && ./configure CFLAGS=\"-g -O2 -mno-avx2\" && make clean && make -s"

RUN chmod +x redsnarf/redsnarf.py && \
	/bin/bash -l -c "cd redsnarf && ./redsnarf.py --auto_complete install"

ENV PATH=$PATH:/opt/redsnarf:/opt/pth-toolkit
VOLUME /tmp/data
WORKDIR /tmp/data

RUN apt-get --purge remove build-essential python-pip && \
	apt-get --purge autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "bash" ]
#CMD [ "-h" ]