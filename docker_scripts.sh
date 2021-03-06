################################
### Docker alias & functions ###
################################

# wpscan
alias wpscan='docker run --rm -it wpscanteam/wpscan'

# redsnarf
alias redsnarf='docker run --rm -it burstears/redsnarf'

# smbclient
#alias smbclient='docker run --rm -it burstears/smbclient smbclient'
alias nmblookup='docker run --rm -it burstears/smbclient nmblookup'
alias rpcclient='docker run --rm -it burstears/smbclient rpcclient'

smbclient() {
    docker run --rm -it -v `pwd`:/tmp burstears/smbclient smbclient $@
}

# enum4linux
alias enum4linux='docker run --rm -it burstears/enum4linux'

# nullinux
alias nullinux='docker run --rm -it burstears/nullinux'

# nbtscan
alias nbtscan='docker run --rm -it burstears/nbtscan'

# sslscanner
alias testssl='docker run --rm -it burstears/sslscanner testssl'
alias sslscan='docker run --rm -it burstears/sslscanner sslscan'
alias sslyze='docker run --rm -it burstears/sslscanner sslyze'

# dirble - may need work for pwd...
alias dirble='docker run --rm -it burstears/dirble'

# Responder.py
alias responder='docker run --rm -it --network="host" burstears/responder'

# CrackMapExec
cme() {docker run --rm -it -v `pwd`:/tmp/data burstears/crackmapexec}

# Sherlock
sherlock() {
  docker run --rm -it -v `pwd`:/root/Documents/Sherlock_Out/ burstears/sherlock /root/Documents/Sherlock_Out/
}

# Eyewitness
eyewitness() {
     a=0
     args=''
     # add docker path prefix to -x and -f
     for arg in "$@"; do
           ((a++))
           if [[ ${@[$((${a}-1))]} == "-x" || ${@[$((${a}-1))]} == "-f" ]]; then
                arg="/tmp/EyeWitness/${arg}"
           fi
           args="${args} ${arg}"
     done
     # run docker command
     eval 'docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/tmp/EyeWitness burstears/eyewitness ${args}'
};

# Alternative script for EyeWitness
# eyewitness(){

#   # --help for this in the event I forget I'm using a docker for this
# if [ $# -eq 0 ]
# then
#     echo "command usage: eyewitness [path_to_folder] [EyeWitness_flags_and_input]"
#     echo "for eyewitness --help, use --extendedhelp"
#     return
# else

#   for arg in "$@"
#   do
#     if [[ "$arg" == "--help" ]] || [[ "$arg" == "-h" ]] #in zsh you need double square brackets for string comparasion
#     then
#       echo "command usage: eyewitness [path_to_folder] [EyeWitness_flags_and_input]"
#       echo "for eyewitness --help, use --extendedhelp or -hh"
#       return
    
#     elif [[ "$arg" == "--extendedhelp" ]] || [[ "$arg" == "-hh" ]]
#     then
#       docker run --rm -it eyewitness --help
#     return
#     else
#     docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $1:/tmp/EyeWitness eyewitness ${@:2} # pass all arguments starting at 2nd argument
#     return
#     fi
#   done
# fi  
# }

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
     if [[ ! ${@[*]} =~ "-u" ]]; then args="${args} -u /opt/snmpwn/users.txt"; fi
     if [[ ! ${@[*]} =~ "-p" ]]; then args="${args} -p /opt/snmpwn/passwords.txt"; fi
     if [[ ! ${@[*]} =~ "-e" ]]; then args="${args} -e /opt/snmpwn/passwords.txt"; fi
     # run docker command
     eval "docker run --rm -it -v `pwd`:/tmp/snmpwn snmpwn ${args}"
};

msfconsole(){

  if [ $# -eq 0 ]
  then
    echo "Working directory is in /tmp/msf"
    echo "Default open ports in use are (for both TCP/UDP):"
    echo "80, 443, 445, 4444, 8080 and 8081"
    echo "\n"
        echo "To use your own ports, please use the -p arg like this: msfconsole -p 8181:8181 -p 8282:8282"
        echo "\n"
    echo "Press enter to continue or Ctrl-C to cancel"
    read
    docker run --rm -it -v ~/.msf4:/root/.msf4 -v `pwd`:/tmp/data burstears/metasploit-standalone
    else
        docker run --rm -it -v ~/.msf4:/root/.msf4 -v `pwd`:/tmp/data $@ burstears/metasploit-standalone
    fi
}

alias odat="docker run --rm -it burstears/odat"

alias rsdns="docker run --rm -it burstears/rsdns"
