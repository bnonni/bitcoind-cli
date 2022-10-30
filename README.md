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
bitcoind-cli installed at /usr/local/bin/
NAME:
	Bitcoind CLI: control script for starting bitcoind

COMMAND:
	bitcoind-cli: control script for starting bitcoind

SUBCOMMANDS:
	help:    show help
	start:   start bitcoind
	stop:    stop bitcoind
	process: print process ID(s)


USAGE:
	bitcoind-cli [subcommand] [-argument] [-option | --option]
	bitcoind-cli [help | -help | --help]
	bitcoind-cli start [-n | --network [-both | -mainnet | -testnet]] | [-both | -mainnet | -testnet] [-l | -log | --log]
	bitcoind-cli stop  [-n | --network [-both | -mainnet | -testnet]] | [-both | -mainnet | -testnet] [-l | -log | --log]
  bitcoind-cli log   [-n | --network [-both | -mainnet | -testnet]] | [-both | -mainnet | -testnet] [-l | -log | --log]
  bitcoind-cli info

EXAMPLES:
	bitcoind-cli start                                                          -> start bitcoind mainnet, logging off
	bitcoind-cli start [-both | -testnet | -mainnet]                            -> start bitcoind testnet and mainnet, logging off
	bitcoind-cli start [-both | -testnet | -mainnet] [-l | -log | --log]        -> start bitcoind testnet and mainnet, logging off
	bitcoind-cli start [[-n | --network] [both | mainnet | testnet]]            -> start bitcoind testnet and mainnet, logging off
	bitcoind-cli stop                                                           -> stop bitcoind mainnet, logging off
	bitcoind-cli stop  [-both | -testnet | -mainnet]                            -> stop bitcoind testnet and mainnet, logging off
	bitcoind-cli stop  [-both | -testnet | -mainnet] [-l | -log | --log]        -> stop bitcoind testnet and mainnet, logging off
	bitcoind-cli stop  [[-n | --network] [both | mainnet | testnet]]            -> start bitcoind testnet and mainnet, logging off
	
VERSION:
	0.0.1


```