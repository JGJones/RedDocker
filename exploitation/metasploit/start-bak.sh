#!/bin/bash

source /usr/local/rvm/scripts/rvm

echo '[+] Initializing postgres'
service postgresql start

echo '[+] Updating msf'
/opt/msf/msfupdate --git-branch master

echo '[+] All done, starting metasploit now...'

tmux new-session "msfconsole; read"