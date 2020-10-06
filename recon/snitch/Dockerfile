FROM ruby:alpine3.12 AS builder

COPY ./ /opt/snitch

RUN apk add build-base ruby-bundler \
    && cd /opt/snitch \
    && rm -rf .git \
    && bundle install

##### Final image #####
FROM ruby:alpine3.12

COPY --from=builder /opt/snitch /opt/snitch
COPY --from=builder /usr/lib/ruby /usr/lib/ruby
COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN apk add nmap nmap-scripts bind-tools

WORKDIR /tmp/snitch

ENTRYPOINT [ "ruby", "/opt/snitch/snitch.rb" ]

# To build docker image:
# docker build -t snitch .
# 
# Alias to make life easier:
# alias snitch="docker run -it -v `pwd`:/tmp/snitch snitch"
