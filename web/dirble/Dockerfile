FROM rust:latest as build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git libssl-dev -y

WORKDIR /home

RUN git clone https://github.com/nccgroup/dirble.git &&\
	cd dirble &&\
	cargo build --release

FROM ubuntu:latest

WORKDIR /opt/dirble

COPY --from=build /home/dirble/target/release/dirble .
COPY --from=build /home/dirble/dirble_wordlist.txt .
COPY --from=build /home/dirble/extensions/* extensions/

# Update base & install requirements
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get dist-upgrade &&\
	apt-get --no-install-recommends -y install \
    libcurl4-openssl-dev &&\
    rm -rf /var/lib/apt/lists/* 

ENTRYPOINT ["./dirble"]
CMD []
