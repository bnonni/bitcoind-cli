# bitcoind-cli
Some very simple (and likely unnecessary) shell code that allows the user to interact with bitcoind specific ways.

## Why?
I was bored, I like shell scripting and I wanted to write something to talk to bitcoind.

## How do I use it?
0. Clone this repo
1. Replace the dummy path (`LOCAL_BIN_FOLDER` ) in `install.bitcoind.cli.sh` to a local filepath found in your $PATH var
2. Replace the `BLOCKCHAIN_DIR` path in `install.bitcoind.cli.sh` w/ the path to your blockchain data & uncomment line 8 (optional)
3. Instead of step 2, you keep line 8 commented out in `install.bitcoind.cli.sh` and go to step 4
4. Run `sh install.bitcoind.cli.sh`
5. You should then see the following ouput:
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
6. If you skipped step 2, you can now run `6. If you skipped step 2, now run `bitcoind-cli setup /path/to/your/blockchain/data`
```
bitcoind-cli setup /path/to/your/blockchain/data
```
