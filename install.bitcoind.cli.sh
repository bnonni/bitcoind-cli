#!/bin/bash
# This folder should be something that's both in your PATH variable and owned by your user
# e.g. on macOS: /usr/local/bin/
LOCAL_BIN_FOLDER=/usr/local/bin/

cp $PWD/bitcoind-cli $LOCAL_BIN_FOLDER

echo "bitcoind-cli installed at $LOCAL_BIN_FOLDER"

bitcoind-cli help