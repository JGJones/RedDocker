# Base image
FROM ruby:alpine 

# Set workdir
WORKDIR /opt/


# Install dependencies

RUN apk --no-cache --virtual tmp add \
    git \
    musl-dev \
    ruby-dev \
    make \
    gcc &&\
#
    gem install \
    winrm \
    winrm-fs \
    stringio &&\
#
    git clone https://github.com/Hackplayers/evil-winrm.git &&\
    chmod +x evil-winrm/*.rb &&\
# Clean and remove useless files
    rm -rf /opt/evil-winrm/resources > /dev/null 2>&1 &&\
    rm -rf /opt/evil-winrm/.github > /dev/null 2>&1 &&\
    rm -rf /opt/evil-winrm/CONTRIBUTING.md > /dev/null 2>&1 &&\
    rm -rf /opt/evil-winrm/CODE_OF_CONDUCT.md > /dev/null 2>&1 &&\
    rm -rf /opt/evil-winrm/Dockerfile > /dev/null 2>&1 &&\
    rm -rf /opt/evil-winrm/Gemfile* > /dev/null 2>&1 &&\
    rm -rf /tmp/* > /dev/null 2>&1 &&\
#
    mkdir /ps1_scripts &&\
    mkdir /exe_files &&\
    mkdir /data &&\
    apk del tmp

#VOLUME /ps1_scripts
#VOLUME /exe_files
#VOLUME /data

# Start command (launching Evil-WinRM)
ENTRYPOINT ["/opt/evil-winrm/evil-winrm.rb"]