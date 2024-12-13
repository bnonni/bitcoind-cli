#!/usr/bin/env bash
# Must run install from within
# This folder should be something that's both in your PATH variable and owned by your user
# e.g. on macOS: /usr/local/bin/
COMMAND=install
pretty_echo () {
  if [[ ! -z $1 && $1 == '-s' ]]; then
    echo "$COMMAND: $2"
    sleep 1
  else
    echo "$COMMAND: $1"
  fi
}


OS="$(uname)"
ARGS=($@)
LOCAL_BIN="/Users/bryan/.local/env/bin"
BITCOIND_CLI="$PWD/bdcli"
BITCOIND_CLI_PATH="$LOCAL_BIN/bdcli"

LOCAL_ETC="/usr/local/etc"
BACKUP_FOLDER="$LOCAL_ETC/bak"
BACKUP_FILE="bdcli.bak"
BACKUP_FILE_FOLER_PATH="$BACKUP_FOLDER/$BACKUP_FILE"

LOCAL_MAN="/usr/local/share/man/man1"
MAN_FILE="$PWD/doc/bdcli.1"
MAN_FILE_FOLER_PATH="$LOCAL_MAN_FOLDER/$MAN_FILE"

sh $PWD/doc/welcome.sh

BITCOIND_CLI_INSTALL_FOLDER=$(dirname $0)
if [[ ! $PWD == $BITCOIND_CLI_INSTALL_FOLDER ]]; then
  cd $BITCOIND_CLI_INSTALL_FOLDER
  echo $'\n'"BITCOIND_CLI_REPO=$PWD" >> $SHELL_PROFILE
  echo $'\n'"BITCOIND_CLI_MAN=" >> $SHELL_PROFILE
fi


pretty_echo "installing bdcli ..."
cp $BITCOIND_CLI $LOCAL_BIN
pretty_echo "bdcli installed at $BITCOIND_CLI_PATH"

pretty_echo "Backing up bdcli ..."
if [[ ! -e $BACKUP_FOLDER ]]; then
  mkdir $BACKUP_FOLDER
fi
cp $BITCOIND_CLI_PATH $BACKUP_FILE_FOLER_PATH
pretty_echo "bdcli backed up to $BACKUP_FILE_FOLER_PATH"

pretty_echo "installing bdcli manual page ..."
cp $MAN_FILE $LOCAL_MAN
pretty_echo "$MAN_FILE backed up to $LOCAL_MAN"
pretty_echo "Done!"
bdcli version
exit 0