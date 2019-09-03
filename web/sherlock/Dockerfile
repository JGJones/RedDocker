FROM ubuntu:latest

RUN useradd -c 'sherlock' -m -s /sbin/nologin sherlock
WORKDIR /home/sherlock

RUN DEBIAN_FRONTEND=noninteractive && \
#
# Set timezone
#
	ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && \
#
# Install packages
#
	apt-get update &&\
	apt-get install -y --no-install-recommends \
	git \
	ruby \
	build-essential \
	patch \
	ruby-dev \
	zlib1g-dev \
	liblzma-dev \
	nmap \
	smbclient \
	curl \
	ike-scan \
	python3 \
	python3-pip \
	python3-setuptools \
	tzdata \
	ntp && \
	dpkg-reconfigure -f noninteractive tzdata && \
#
# Install sherlock
#
	git clone https://github.com/hatlord/sherlock && \
	cd sherlock && \
	gem install bundler && \
	bundle install && \
#
# old SSL support
#
	mkdir /home/sherlock/deps && \
	cd /home/sherlock/deps && \
	curl -O -L https://openssl.org/source/openssl-1.0.2k.tar.gz && \
	tar -xf openssl-1.0.2k.tar.gz && \
	cd openssl-1.0.2k && \
	./config --prefix=`pwd`/local --openssldir=/usr/lib/ssl enable-ssl2 enable-ssl3 no-shared && \
	make depend && \
	make && \
	make -i install && \
	cp local/bin/openssl /usr/local/bin/ && \
	cd .. && \
	rm -rf openssl-1.0.2k && rm openssl-1.0.2k.tar.gz && \
#
# testssl.sh
#
	git clone https://github.com/drwetter/testssl.sh.git && \
	ln -s /home/sherlock/deps/testssl.sh/testssl.sh /usr/local/bin/testssl.sh && \
#
# sslscan
#
	git clone https://github.com/rbsec/sslscan.git && \
	cd sslscan && \
	make static && \
	make install && \
	pip3 install --upgrade setuptools && \
	pip3 install --upgrade sslyze && \
#
# Clean up
#
	apt clean -y && \
	apt --purge -y remove \
	git \
	build-essential \
	patch \
	ruby-dev \
	zlib1g-dev \
	liblzma-dev \
	ruby-dev \
	curl \
	python3-pip \
	python3-setuptools && \
	rm -rf /var/lib/apt/lists/*

USER root
ENTRYPOINT [ "ruby", "/home/sherlock/sherlock/sherlock.rb" ]
