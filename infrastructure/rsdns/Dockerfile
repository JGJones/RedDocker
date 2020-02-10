FROM alpine:3.11

WORKDIR /opt
RUN 	apk add ruby ruby-io-console &&\
	apk add --no-cache --virtual tmp ruby-bundler git &&\
	git clone https://github.com/hatlord/rsdns.git &&\
	cd rsdns &&\
	bundle install &&\
	rm -Rf .git &&\
	apk del tmp

WORKDIR /opt/rsdns

ENTRYPOINT ["./rsdns.rb"]
CMD ["-h"]
