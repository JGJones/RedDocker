FROM alpine:latest

#RUN useradd -c 'snmpwn' -m -s /sbin/nologin snmpwn
WORKDIR /opt

RUN apk update && apk upgrade &&\
    apk --no-cache add \
    git \
    ruby \
    ruby-rdoc && \
#
#   Fetch snmpwn and set up
#
    git clone https://github.com/hatlord/snmpwn && \
    cd snmpwn && \
    rm -rf .git && \
    gem install bundler && \
    bundle install && \
#
#   Clean up
#
    apk --purge del git && \
    rm -rf /var/cache/apk/*

ENV PATH="/opt/snmpwn/:${PATH}"
USER nobody

ENTRYPOINT [ "snmpwn.rb" ]
CMD [ "--help" ]