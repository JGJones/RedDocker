FROM ubuntu
LABEL maintainer="JGJones"

# Reference:
# https://gist.github.com/vestjoe/68b579d07f6a685b15d05f55908883cc
# Using https://github.com/belane/docker-bloodhound (dockerfile breaks)

USER root
WORKDIR /opt
COPY config/*.json /root/.config/bloodhound/
COPY scripts/run.sh /opt/run.sh

ARG DEBIAN_FRONTEND=noninteractive
ARG bloodhound=2.2.1
ARG data=none

# Get neo4j and other packages
RUN apt-get update && \
    apt-get install -y \
    --no-install-recommends \
    wget \
    curl \
    ca-certificates \
    gnupg2 && \
    wget -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add - && \
	echo 'deb http://debian.neo4j.org/repo stable/' | tee /etc/apt/sources.list.d/neo4j.list && \
	#echo "deb http://httpredir.debian.org/debian jessie-backports main" | sudo tee -a /etc/apt/sources.list.d/jessie-backports.list && \
	apt-get update && \
	apt-get install -y \
	--no-install-recommends \
	openjdk-8-jdk \
	openjdk-8-jre \
	git \
    unzip \
    gnupg \
    libgtk2.0-bin \
    libcanberra-gtk-module \
    libx11-xcb1 \
    libva-glx2 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libgconf-2-4 \
    libasound2 \
    libxss1 \
	neo4j && \
	apt-get clean && \
    apt-get purge gnupg2 -y && \
    apt-get --purge autoremove -y && \
 	rm -rf /var/lib/{apt,dpkg,cache,log,lists}/

# Get Bloodhound

RUN wget https://github.com/BloodHoundAD/BloodHound/releases/download/$bloodhound/BloodHound-linux-x64.zip -nv -P /tmp && \
    unzip /tmp/BloodHound-linux-x64.zip -d /opt/ && \
    mkdir /data && \
    chmod +x /opt/BloodHound-linux-x64/BloodHound && \
    rm /tmp/BloodHound-linux-x64.zip

# # Clean up
# #
# 	apt-get --purge remove ca-certificates build-essential python-setuptools python-pip git -y && \
# 	apt-get --purge autoremove -y && \
# 	apt-get clean && \
# 	rm -rf /var/lib/apt/lists/*

RUN if [ "$data" = "example" ]; then \
    git clone https://github.com/adaptivethreat/BloodHound.git /tmp/BloodHound/ &&\
    cp -r /tmp/BloodHound/BloodHoundExampleDB.graphdb /var/lib/neo4j/data/databases/ &&\
    chown -R neo4j:neo4j /var/lib/neo4j/data/databases/BloodHoundExampleDB.graphdb/ &&\
    echo "dbms.active_database=BloodHoundExampleDB.graphdb" >> /etc/neo4j/neo4j.conf &&\
    echo "dbms.allow_upgrade=true" >> /etc/neo4j/neo4j.conf; fi

VOLUME /data

ENTRYPOINT ["bash"]