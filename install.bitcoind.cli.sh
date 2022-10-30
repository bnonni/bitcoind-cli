#!/bin/bash
# This folder should be something that's both in your PATH variable and owned by your user
# e.g. on macOS: /usr/local/bin/
LOCAL_BIN_FOLDER=/path/to/a/bin/executable/folder/locally

cp $LOCAL_BIN/bitcoind-cli $LOCAL_BIN_FOLDER

echo "bitcoind-cli installed at $LOCAL_BIN_FOLDER"

bitcoind-cli help