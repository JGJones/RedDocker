First get the Dockerfile from the EyeWitness git repository:

	wget https://raw.githubusercontent.com/FortyNorthSecurity/EyeWitness/master/Dockerfile

Run the following command to build:

	docker build --build-arg user=$USER --tag eyewitness .

(there's also a run.sh to do the above if you like)

Function to put into your .zshrc or .bashrc file:

	eyewitness(){

		# --help for this in the event I forget I'm using a docker for this
		if [ $# -eq 0 ]
		then
		    echo "command usage: eyewitness [path_to_folder] [EyeWitness_flags_and_input]"
		    echo "for eyewitness --help, use --extendedhelp"
		    return
		else
		for arg in "$@"
		do
			if [[ "$arg" == "--help" ]] || [[ "$arg" == "-h" ]] #in zsh you need double square brackets for string comparasion
			then
				echo "command usage: eyewitness [path_to_folder] [EyeWitness_flags_and_input]"
				echo "for eyewitness --help, use --extendedhelp or -hh"
				return
			
			elif [[ "$arg" == "--extendedhelp" ]] || [[ "$arg" == "-hh" ]]
			then
				docker run --rm -it web/eyewitness --help
			return
			else
			docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $1:/tmp/EyeWitness web/eyewitness ${@:2} # pass all arguments starting at 2nd argument
			return
			fi
		done
		fi	
	}


Improved function - must be run within folder containing nessus file

	eyewitness() {
	     i=0
	     args=''
	     # add docker path prefix to -x and -f
	     for arg in "$@"; do
	           ((i++))
	           if [[ ${@[$((${i}-1))]} == "-x" || ${@[$((${i}-1))]} == "-f" ]]; then
	                arg="/tmp/EyeWitness/${arg}"
	           fi
	           args="${args} ${arg}"
	     done
	     # run docker command
	     eval "docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/tmp/EyeWitness eyewitness ${args}"
	};
