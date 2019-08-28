FROM ubuntu
LABEL maintainer="JGJones"

# References:
# https://www.darkoperator.com/installing-metasploit-in-ubunt/
# https://www.pentestgeek.com/tools/install-metasploit-framework-ubuntu

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y postgresql postgresql postgresql-client postgresql-contrib \
	nmap tmux git build-essential nano vim curl wget htop \
	libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev \
	libpcap-dev autoconf pgadmin3 zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev \
	zlib1g-dev gawk bison libffi-dev libgdbm-dev libncurses5-dev libtool sqlite3 \
	libgmp-dev gnupg2 dirmngr ntpdate gnupg2 sudo && \
	rm -rf /var/lib/apt/lists/*

USER root

# Copy tmux.conf
COPY tmux.conf /root/.tmux.conf

# Get Metasploit and set it up
WORKDIR /opt
RUN git clone https://github.com/rapid7/metasploit-framework.git msf
WORKDIR msf

## Set up Postgresql
COPY db.sql /tmp
RUN service postgresql start && su postgres -c "psql -f /tmp/db.sql"

## Get RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
RUN curl -L https://get.rvm.io | bash -s stable 
RUN /bin/bash -l -c "rvm --install ruby-`cat .ruby-version`"
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm use `cat .ruby-version` --default"
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm"
RUN /bin/bash -l -c "gem install bundler --no-document"
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && which bundle"
RUN /bin/bash -l -c "which bundle"

# Ruby dependencies
RUN /bin/bash -l -c "BUNDLEJOBS=$(expr $(cat /proc/cpuinfo | grep vendor_id | wc -l) - 1)"
RUN /bin/bash -l -c "bundle config --global jobs $BUNDLEJOBS"
RUN /bin/bash -l -c "bundle install"

COPY ./database.yml /opt/msf/config

# Symlink tools to $PATH
RUN ln -s /opt/msf/msf* /usr/local/bin
RUN for i in `ls /opt/msf/tools/*/*`; do ln -s $i /usr/local/bin/; done

# Copying entrypoint file

COPY start.sh /
RUN chmod +x /start.sh

# Set volumes for data

VOLUME /root/.msf4
VOLUME /tmp/data

# For backconnect shellcodes (or payloads as if you want to use fancy names)
EXPOSE 4444/tcp
EXPOSE 4444/udp

# Opening some typical ports
EXPOSE 80/tcp
EXPOSE 80/udp
EXPOSE 8080/tcp
EXPOSE 8080/udp
EXPOSE 443/tcp
EXPOSE 443/udp
EXPOSE 445/tcp
EXPOSE 445/udp
EXPOSE 8081/tcp
EXPOSE 8081/udp

ENTRYPOINT ["/start.sh"]