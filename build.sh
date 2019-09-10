#!/bin/bash

# https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script

title="Select docker image to build"
prompt="Pick an option:"
options=(
	"enum4linux"
	"nullinux"
	"CrackMapExec"
	"RedSnarf"
	"smbclient"
	"metasploit"
	)

# This just present a menu to build docker image. 
# TODO confirm for each action?
# TODO Add alias/function to end of .bashrc / .zshrc 

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do

	case "$REPLY" in

		1 ) docker build -t enum4linux windows/enum4linux ;;
		2 ) docker build -t nullinux windows/nullinux ;;
		3 ) docker build -t crackcapexec windows/CrackMapExec ;;
		4 ) docker build -t redsnarf windows/RedSnarf ;;
		5 ) docker build -t smbclient windows/smbclient ;;
		6 ) docker build -t metasploit exploitation/metasploit ;;

    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
    *) echo "Invalid option. Try another one.";continue;;

    esac

done

