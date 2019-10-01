##### builder image #####
FROM alpine:latest AS builder
LABEL maintainer="JGJones"

RUN apk --no-cache add \
	patch \
	ruby-dev \
	ruby-rdoc \
	zlib-dev \
	xz-dev \
	git \
	openssl-dev \
	build-base \
	autoconf \
	automake && \
	rm -rf /var/cache/apk/*

WORKDIR /opt

# IKE-SCAN

RUN git clone https://github.com/royhills/ike-scan.git &&\
	cd ike-scan &&\
	autoreconf --install &&\
	./configure --with-openssl &&\
	make &&\
	make install

# SHERLOCK 

COPY sherlock/Gemfile /opt
RUN gem install bundler
RUN bundle install

##### final image #####
FROM alpine:latest
LABEL maintainer="JGJones"

COPY --from=builder /usr/lib/ruby /usr/lib/ruby
COPY --from=builder /usr/local/bin/ike-scan /usr/local/bin/ike-scan
COPY --from=builder /usr/local/bin/psk-crack /usr/local/bin/psk-crack
COPY --from=builder /usr/local/share/ike-scan /usr/local/share/ike-scan
COPY sherlock /opt/sherlock

WORKDIR /opt

RUN apk add --no-cache sslscan --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ &&\
	apk update && apk upgrade &&\
	apk --no-cache add \
	# Required pkgs for testssl
	drill coreutils curl procps bash \
	# Required pkgs for sherlock
	nmap samba-client curl ruby ntpsec\
	# Remove after use
	git &&\
	# Finalise build
	git clone --depth=1 https://github.com/drwetter/testssl.sh.git &&\
	ln -s /opt/testssl.sh/testssl.sh /usr/local/bin/testssl.sh &&\
	apk del git &&\
	rm -rf /var/cache/apk/*

#USER root
ENTRYPOINT [ "ruby", "/opt/sherlock/sherlock.rb" ]