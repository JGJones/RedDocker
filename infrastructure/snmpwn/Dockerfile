FROM alpine:3.10

#RUN useradd -c 'snmpwn' -m -s /sbin/nologin snmpwn
WORKDIR /opt

RUN apk --no-cache upgrade &&\
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
    apk del git

USER nobody

ENTRYPOINT [ "/opt/snmpwn/snmpwn.rb" ]
CMD [ "--help" ]

# Function for bashrc/zshrc

# snmpwn() {
#      a=0
#      args=''
#      # add docker path prefix
#      for arg in "$@"; do
#            ((a++))
#            if [[ ${@[$((${a}-1))]} =~ "-[hupe]"  ]]; then
#                 arg="/tmp/snmpwn/${arg}"
#            fi
#            args="${args} ${arg}"
#      done
#      # if no users/passwords/encryption file then use defaults
#      if [[ ! ${@[*]} =~ "-u" ]]; then args="${args} -u /opt/snmpwn/users.txt"; fi
#      if [[ ! ${@[*]} =~ "-p" ]]; then args="${args} -p /opt/snmpwn/passwords.txt"; fi
#      if [[ ! ${@[*]} =~ "-e" ]]; then args="${args} -e /opt/snmpwn/passwords.txt"; fi
#      # run docker command
#      eval "docker run --rm -it -v `pwd`:/tmp/snmpwn snmpwn ${args}"
# };
