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
	bitcoind-cli: control script for starting/stopping & logging bitcoind

 USAGE:
	bitcoind-cli [subcommand] [-argument] | [-option | --option]
 	bitcoind-cli [ help | -help | --help]
 	bitcoind-cli start [-both | -mainnet | -testnet] [-l | --log]
 	bitcoind-cli stop [-both | -mainnet | -testnet] [-l | --log]
 	Examples:
 		bitcoind-cli start                       -> start bitcoind mainnet, logging off
 		bitcoind-cli start -both                 -> start bitcoind testnet and mainnet, logging off
 		bitcoind-cli start -testnet              -> start bitcoind testnet, logging off
 		bitcoind-cli start -mainnet              -> start bitcoind mainnet, logging on
 		bitcoind-cli start -both    [-l | --log] -> start bitcoind testnet and mainnet, logging on
 		bitcoind-cli start -mainnet [-l | --log] -> start bitcoind mainnet, logging on
 		bitcoind-cli start -testnet [-l | --log] -> start bitcoind testnet, logging on
 		bitcoind-cli stop                        -> stop bitcoind mainnet, logging off
 		bitcoind-cli stop -both                  -> stop bitcoind testnet and mainnet, logging off
 		bitcoind-cli stop -testnet               -> stop bitcoind testnet, logging off
 		bitcoind-cli stop -mainnet               -> stop bitcoind mainnet, logging on
 
VERSION:
	0.0.1
```