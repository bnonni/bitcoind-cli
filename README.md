# bitcoind-cli
Some very simple and likely unnecessary shell code that allows the user to interact with bitcoind in a simple & specific way.

## Why?
I was bored and I like shell scripting.

## How do I use it?
- Clone this repo
- Replace the dummy path (`LOCAL_BIN_FOLDER` ) in `install.bitcoind.cli.sh` to a local path
- Run `sh install.bitcoind.cli.sh`
- You should then see the following ouput:

```
NAME: 
	Bitcoind CLI: control script for starting bitcoind 

COMMAND: 
	bitcoind-cli: control script for starting bitcoind 

SUBCOMMANDS: 
	help:    show help 
	info:    show PIDs 
	log:     tail bitcoind logs 
	start:   start bitcoind 
	stop:    stop bitcoind 

USAGE: 
	% bitcoind-cli subcommand [-arg | -option arg | --option arg] 
	% bitcoind-cli help 
	% bitcoind-cli info 
	% bitcoind-cli log [-both | -mainnet | -testnet] [-n | --network <both | mainnet | testnet>] 
	% bitcoind-cli start [-both | -mainnet | -testnet] [-n | --network <both | mainnet | testnet>] [-l | -log | --log] 
	% bitcoind-cli stop [-both | -mainnet | -testnet] [-n | --network <both | mainnet | testnet>] [-l | -log | --log] 

EXAMPLES: 
	- help: print info about the command, subcommands, usage and examples 
	% bitcoind-cli help 

	- info: print the PIDs for the bitcoind processes 
	% bitcoind-cli info 

	- log: print the debug.log files for bitcoind using tail command 
	% bitcoind-cli log 
		[-both | -testnet | -mainnet] 
		[-n | --network both | mainnet | testnet] 

	- start: start bitcoind, default: mainnet & logging disabled 
	% bitcoind-cli start 
		[-both | -testnet | -mainnet] 
		[-n | --network both | mainnet | testnet] 
		[-l | -log | --log] 

	- stop: start bitcoind, default: mainnet & logging disabled 
	% bitcoind-cli stop 
		[-both | -testnet | -mainnet] 
		[-n | --network both | mainnet | testnet] 

VERSION:
	0.0.1
```