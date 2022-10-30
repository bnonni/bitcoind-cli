#!/bin/bash
# set inclusion
WORD=$1
if [[ "$WORD" =~ ^(cat|dog|horse)$ ]]; then
    echo "$WORD is in the list"
else
    echo "$WORD is not in the list"
fi

# switch case
case $WORD in
    dog|cat|horse) echo yes;;
    *) echo no;;
esac
