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