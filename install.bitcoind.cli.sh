#!/usr/bin/env bash
# This folder should be something that's both in your PATH variable and owned by your user
# e.g. on macOS: /usr/local/bin/
ARGS=($@)
LOCAL_BIN_FOLDER=/usr/local/bin/
BACKUP_FILE=bitcoind-cli.bak
BACKUP_FILE_PATH=$PWD/$BACKUP_FILE
SHOW_HELP=$(echo "${ARGS[0]}" | tr -d -)

echo "Installing bitcoind-cli..."
cp $PWD/bitcoind-cli $LOCAL_BIN_FOLDER
echo "bitcoind-cli installed at $LOCAL_BIN_FOLDER"

# TODO: bitcoind-cli setup BLOCKCHAIN_DIR=/Volumes/BLOCKCHAIN

echo "Backing up bitcoind-cli..."
cp $PWD/bitcoind-cli $BACKUP_FILE_PATH
echo "bitcoind-cli backed up to $BACKUP_FILE_PATH"


if [[ $SHOW_HELP =~ ^(h|H|help)$ ]]; then
  bitcoind-cli help
elif [[ -z $SHOW_HELP ]]; then
  echo "Would you like to see the bitcoind-cli usage guide? [y|N]"
  read SHOW_HELP
else
  echo "For help with using the cli, run bitcoind-cli help"
fi
