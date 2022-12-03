#!/bin/bash
# set inclusion
WORD=$1
if [[ "$WORD" =~ ^(cat|dog|horse)$ ]]; then
    echo "$WORD is in the list"
else
    echo "$WORD is not in the list"
fi

# echo ""

# switch case
case $WORD in
    dog|cat|horse) echo "$WORD is in the list";;
    *) echo "$WORD is not in the list";;
esac

# echo ""

ARGS=($@)
SUBCOMMAND=${ARGS[0]}
NETWORK_ARG=${ARGS[1]}
NETWORK=$(echo "$NETWORK_ARG" | tr -d -)
LOG=${ARGS[2]}

echo "SUBCOMMAND: $SUBCOMMAND"
echo "NETWORK_ARG: $NETWORK_ARG"
echo "NETWORK: $NETWORK"
echo "LOG: $LOG"

if [[ $NETWORK_ARG == "-n" || $NETWORK_ARG == "--network" ]]; then
    NETWORK_FLAG=1
    NETWORK=${ARGS[2]}
    LOG=${ARGS[3]}
fi

echo "NETWORK_FLAG: $NETWORK_FLAG"
echo "SUBCOMMAND: $SUBCOMMAND"
echo "NETWORK_ARG: $NETWORK_ARG"
echo "NETWORK: $NETWORK"
echo "LOG: $LOG"


echo "NAME:" $'\n'$'\t'\
"Bitcoind CLI: control script for starting bitcoind" $'\n'$'\n'\
"COMMAND:" $'\n'$'\t'\
"bitcoind-cli: control script for starting bitcoind" $'\n'$'\n'\
"SUBCOMMANDS:" $'\n'$'\t'\
"help:    show help" $'\n'$'\t'\
"setup:   setup cli pathing" $'\n'$'\t'\
"info:    show PIDs" $'\n'$'\t'\
"disk:    interact with ext disk" $'\n'$'\t'\
"log:     tail bitcoind logs" $'\n'$'\t'\
"start:   start bitcoind" $'\n'$'\t'\
"stop:    stop bitcoind" $'\n'$'\t'\
"restart: restart bitcoind (stop + start)"$'\n'$'\n'\
"USAGE:" $'\n'$'\t'\
"% bitcoind-cli subcommand [-arg | -option arg | --option arg]" $'\n'$'\t'\
"% bitcoind-cli help" $'\n'$'\t'\
"% bitcoind-cli setup [/path/to/blockchain/data | -i | --interactive]" $'\n'$'\t'\
"% bitcoind-cli info [-all | -mainnet | -testnet | -signet] [-n | --network <all | mainnet | testnet | signet>]" $'\n'$'\t'\
"% bitcoind-cli disk [-m | mount | -mount | --mount] [-u | unmount | -unmount | --unmount]" $'\n'$'\t'\
"% bitcoind-cli log [-all | -mainnet | -testnet | -signet] [-n | --network <all | mainnet | testnet | signet>]" $'\n'$'\t'\
"% bitcoind-cli disk [mount | unmount]" $'\n'$'\t'\
"% bitcoind-cli start [-all | -mainnet | -testnet | -signet] [-n | --network <all | mainnet | testnet | signet>] [-l | -log | --log]" $'\n'$'\t'\
"% bitcoind-cli stop [-all | -mainnet | -testnet | -signet] [-n | --network <all | mainnet | testnet | signet>] [-l | -log | --log]" $'\n'$'\t'\
"% bitcoind-cli restart [-all | -mainnet | -testnet | -signet] [-n | --network <all | mainnet | testnet | signet>] [-l | -log | --log]" $'\n'$'\n'\
"EXAMPLES:" $'\n'$'\t'\
\
"- help: print info about the command, subcommands, usage and examples" $'\n'$'\t'\
"% bitcoind-cli help" $'\n'$'\n'$'\t'\
\
"- setup: set the path to your blockchain data in shell profile" $'\n'$'\t'\
"% bitcoind-cli setup /Volumes/BLOCKCHAIN" $'\n'$'\n'$'\t'\
\
"- info: print the PIDs for the bitcoind processes" $'\n'$'\t'\
"% bitcoind-cli info -all" $'\n'$'\t'$'\t'\
"[-all | -testnet | -mainnet | -signet]" $'\n'$'\t'$'\t'\
"[-n | --network all | mainnet | testnet | signet]"$'\n'$'\n'$'\t'\
\
"- disk: interact with an external disk housing blockchain data" $'\n'$'\t'\
"% bitcoind-cli disk mount" $'\n'$'\t'$'\t'\
"[mount | unmount]"$'\n'$'\n'$'\t'\
\
"- log: print the debug.log files for bitcoind using tail command" $'\n'$'\t'\
"% bitcoind-cli log -all" $'\n'$'\t'$'\t'\
"[-all | -testnet | -mainnet | -signet]" $'\n'$'\t'$'\t'\
"[-n | --network all | mainnet | testnet | signet]"$'\n'$'\n'$'\t'\
\
"- start: start bitcoind, default: all & logging disabled" $'\n'$'\t'\
"% bitcoind-cli start -all" $'\n'$'\t'$'\t'\
"[-all | -testnet | -mainnet | -signet]" $'\n'$'\t'$'\t'\
"[-n | --network all | mainnet | testnet | signet]" $'\n'$'\t'$'\t'\
"[-l | -log | --log]" $'\n'$'\n'$'\t'\
\
"- stop: stop bitcoind, default: all & logging disabled" $'\n'$'\t'\
"% bitcoind-cli stop -all" $'\n'$'\t'$'\t'\
"[-all | -testnet | -mainnet | -signet]" $'\n'$'\t'$'\t'\
"[-n | --network all | mainnet | testnet | signet] "$'\n'$'\n'$'\t'\
\
"- restart: restart bitcoind, default: all & logging disabled" $'\n'$'\t'\
"% bitcoind-cli restart -all" $'\n'$'\t'$'\t'\
"[-all | -testnet | -mainnet | -signet]" $'\n'$'\t'$'\t'\
"[-n | --network all | mainnet | testnet | signet] "$'\n'$'\n'\
"VERSION:" $'\n'$'\t'\
"0.0.1" $'\n';
exit 0;