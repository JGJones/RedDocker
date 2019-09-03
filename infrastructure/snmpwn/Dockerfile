FROM ubuntu

RUN useradd -c 'snmpwn' -m -s /sbin/nologin snmpwn

WORKDIR /home/snmpwn

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    ruby && \
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
    apt-get --purge remove git -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/home/snmpwn/snmpwn/:${PATH}"
USER snmpwn

ENTRYPOINT [ "snmpwn.rb" ]
CMD [ "--help" ]