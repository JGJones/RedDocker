First get the Dockerfile from the EyeWitness git repository:

	wget https://raw.githubusercontent.com/almandin/fuxploider/master/Dockerfile

Run the following command to build:

	docker build -t almandin/fuxploider .

(there's also a run.sh to do the above if you like)

Alias to put into your .zshrc or .bashrc file:

	alias fuxploider="docker run --rm -it fuxploider"
