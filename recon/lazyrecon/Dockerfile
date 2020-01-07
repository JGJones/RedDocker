#===========================
#====== Build 1 Stage ======
#===========================
FROM golang:1.13-alpine AS build1
RUN apk add git
RUN go get github.com/michenriksen/aquatone; exit 0
RUN go get -u github.com/tomnomnom/httprobe; exit 0
RUN go get github.com/tomnomnom/waybackurls; exit 0
RUN go get github.com/OWASP/Amass; exit 0
RUN go get -u github.com/tomnomnom/unfurl; exit 0
ENV GO111MODULE on
WORKDIR /go/src/github.com/OWASP/Amass
RUN go install ./...


# Getting a base image to use for build2 and final

FROM python:3-alpine AS base


#===========================
#====== Build 2 Stage ======
#===========================

FROM base as build2

LABEL maintainer JGJones
#ENV HOME="/home/lazyrecon_user"
ENV HOME="/opt"
ENV TOOLS="/opt/tools"
ENV VENV="/opt/venv"
ENV VENV3="/opt/venv3"
#ENV TERM="xterm-256color"
#ENV LC_ALL="en_US.UTF-8"
#ENV LANG="en_US.UTF-8"
#ENV LANGUAGE="en_US.UTF-8"

RUN apk add --no-cache \
    curl-dev \
    openssl-dev \
 #   jq \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
#    ruby-dev \
    build-base \
    gmp-dev \
    zlib-dev \
    libffi-dev \
    python2-dev \
    ldns-dev \
    py2-pip \
    git \
    wget \
    bind-tools

RUN pip2 install virtualenv &&\
    virtualenv -p /usr/bin/python2 $VENV &&\
    pip3 install virtualenv &&\
    python3 -m virtualenv -p /usr/local/bin/python3 $VENV3

# RUN set -x \
#     && addgroup --gid 1000 lazyrecon_user \
#     && adduser --uid 1000 --ingroup lazyrecon_user --home /home/lazyrecon_user --shell /bin/bash --disabled-password --gecos "" lazyrecon_user

WORKDIR $TOOLS
RUN git clone https://github.com/aboul3la/Sublist3r.git &&\
    git clone https://github.com/maurosoria/dirsearch.git &&\
    git clone https://github.com/blechschmidt/massdns.git &&\
    git clone https://github.com/gnebbia/pdlist &&\
    pip3 install dnsgen

ENV PATH="$VENV/bin:$VENV3/bin:$PATH"

WORKDIR $TOOLS/Sublist3r
RUN pip install -r requirements.txt

WORKDIR $TOOLS/massdns
RUN make

WORKDIR $TOOLS/SecLists/Discovery/DNS/
RUN wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/dns-Jhaddix.txt \
    && cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt

WORKDIR $TOOLS/pdlist
RUN pip3 install -r requirements.txt &&\
    python3 setup.py install

#=========================
#====== Final Stage ======
#=========================
FROM base

ENV HOME="/opt"
ENV TOOLS="/opt/tools"
ENV VENV=/opt/venv
ENV VENV3=/opt/venv3
ENV PATH="$VENV/bin:$VENV3/bin:$PATH"

# Copy from Build1
COPY --from=build1 /go/bin/amass /bin/amass
COPY --from=build1 /go/bin/aquatone /bin/aquatone
COPY --from=build1 /go/bin/httprobe /bin/httprobe
COPY --from=build1 /go/bin/waybackurls /bin/waybackurls
COPY --from=build1 /go/bin/unfurl /bin/unfurl

# Copy from Build2
COPY --from=build2 $VENV $VENV
COPY --from=build2 $VENV3 $VENV3
COPY --from=build2 $TOOLS/Sublist3r $TOOLS/Sublist3r
COPY --from=build2 $TOOLS/SecLists $TOOLS/SecLists
COPY --from=build2 $TOOLS/massdns/bin $TOOLS/massdns/bin
COPY --from=build2 $TOOLS/dirsearch $TOOLS/dirsearch

RUN apk --no-cache add \
    nmap \
    curl \
    bash \
    ncurses \
    jq
    #chromium

WORKDIR /usr/local/bin
RUN curl https://raw.githubusercontent.com/soaringswine/lazyrecon_docker/master/lazyrecon.sh -o lazyrecon.sh &&\
    chmod +x lazyrecon.sh

# Change home directory ownership and fix TLDextract caching permission error.
#RUN set -x \
#    && chown -R lazyrecon_user:lazyrecon_user $HOME \
#    && chown -R lazyrecon_user:lazyrecon_user /usr/local/lib/python3.6/dist-packages/tldextract/
# Using fixuid to fix bind mount permission issues.
# RUN set -x \
#     && USER=lazyrecon_user \
#     && GROUP=lazyrecon_user \
#     && curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - \
#     && chown root:root /usr/local/bin/fixuid \
#     && chmod 4755 /usr/local/bin/fixuid \
#     && mkdir -p /etc/fixuid \
#     && printf "user: $USER\ngroup: $GROUP\npaths: \n - /\n - $TOOLS/lazyrecon/lazyrecon_results\n" > /etc/fixuid/config.yml
# USER lazyrecon_user:lazyrecon_user
# Fix Chromium working with Aquatone in Docker. Chromium now runs without a sandbox, but since we're in a container, it's an ok trade-off.
#RUN printf 'CHROMIUM_FLAGS="--no-sandbox --headless"\n' > $HOME/.chromium-browser.init
#ENTRYPOINT ["fixuid", "/bin/bash"]
WORKDIR /tmp

ENTRYPOINT ["lazyrecon.sh"]