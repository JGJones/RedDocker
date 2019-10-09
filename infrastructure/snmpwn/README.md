snmpwn() {
     a=0
     args=''
     # add docker path prefix
     for arg in "$@"; do
           ((a++))
           if [[ ${@[$((${a}-1))]} =~ "-[hupe]"  ]]; then
                arg="/tmp/snmpwn/${arg}"
           fi
           args="${args} ${arg}"
     done
     # if no users/passwords/encryption file then use defaults
     if [[ ! ${@[*]} =~ "-u" ]]; then args="${args} -u /home/snmpwn/snmpwn/users.txt"; fi
     if [[ ! ${@[*]} =~ "-p" ]]; then args="${args} -p /home/snmpwn/snmpwn/passwords.txt"; fi
     if [[ ! ${@[*]} =~ "-e" ]]; then args="${args} -e /home/snmpwn/snmpwn/passwords.txt"; fi
     # run docker command
     eval "docker run --rm -it -v `pwd`:/tmp/snmpwn snmpwn ${args}"
};
