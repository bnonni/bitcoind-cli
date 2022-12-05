#!/usr/bin/env bash
VERSION="v0.0.2"
COMMAND="install"
pretty_echo () {
  if [[ ! -z $1 && $1 == '-s' ]]; then 
    echo "$COMMAND: $2"
    sleep 1
  elif [[ ! -z $2 && $2 == '-s' ]]; then 
    echo "$COMMAND: $1"
    sleep 1
  else
    echo "$COMMAND: $1"
  fi
}

OS=$(uname)
ARGS=($@)
LOCAL_BIN=/usr/local/bin
BITCOIND_CLI=$PWD/bitcoind-cli
BITCOIND_CLI_PATH=$LOCAL_BIN/bitcoind-cli

LOCAL_ETC=/usr/local/etc
BACKUP_FOLDER=$LOCAL_ETC/bak
BACKUP_FILE=bitcoind-cli-$VERSION.bak
BACKUP_FILE_FOLER_PATH=$BACKUP_FOLDER/$BACKUP_FILE

LOCAL_MAN=/usr/local/share/man/man1
MAN_FILE=bitcoind-cli.1
MAN_FILE_FOLER_PATH=$LOCAL_MAN/$MAN_FILE

echo '\033[38;5;208m -----------------------------------------------------------------------------------------------------------------\033[0m'
echo '\033[38;5;208m|  _______   ______  ________  ______    ______   ______  __    __  _______            ______   __        ______  |\033[0m'
echo '\033[38;5;208m| /       \ /      |/        |/      \  /      \ /      |/  \  /  |/       \          /      \ /  |      /      | |\033[0m'
echo '\033[38;5;208m| $$$$$$$  |$$$$$$/ $$$$$$$$//$$$$$$  |/$$$$$$  |$$$$$$/ $$  \ $$ |$$$$$$$  |        /$$$$$$  |$$ |      $$$$$$/  |\033[0m'
echo '\033[38;5;208m| $$ |__$$ |  $$ |     $$ |  $$ |  $$/ $$ |  $$ |  $$ |  $$$  \$$ |$$ |  $$ | ______ $$ |  $$/ $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$    $$<   $$ |     $$ |  $$ |      $$ |  $$ |  $$ |  $$$$  $$ |$$ |  $$ |/      |$$ |      $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$$$$$$  |  $$ |     $$ |  $$ |   __ $$ |  $$ |  $$ |  $$ $$ $$ |$$ |  $$ |$$$$$$/ $$ |   __ $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$ |__$$ | _$$ |_    $$ |  $$ \__/  |$$ \__$$ | _$$ |_ $$ |$$$$ |$$ |__$$ |        $$ \__/  |$$ |_____  _$$ |_  |\033[0m'
echo '\033[38;5;208m| $$    $$/ / $$   |   $$ |  $$    $$/ $$    $$/ / $$   |$$ | $$$ |$$    $$/         $$    $$/ $$       |/ $$   | |\033[0m'
echo '\033[38;5;208m| $$$$$$$/  $$$$$$/    $$/    $$$$$$/   $$$$$$/  $$$$$$/ $$/   $$/ $$$$$$$/           $$$$$$/  $$$$$$$$/ $$$$$$/  |\033[0m'
echo '\033[38;5;208m -----------------------------------------------------------------------------------------------------------------\033[0m'
echo ""

pretty_echo -s "welcome to the bitcoind-cli installer!"

BASHRC=~/.bashrc
BASH_PROFILE=~/.bash_profile
ZSHRC=~/.zshrc
PROFILE=~/.profile
if [[ $SHELL == "/bin/bash" && -f $BASHRC ]]; then
  SHELL_PROFILE=$BASHRC
elif [[ $SHELL == "/bin/bash" && -f $BASH_PROFILE ]]; then
  SHELL_PROFILE=$BASH_PROFILE
elif [[ $SHELL == "/bin/zsh" && -f $ZSHRC  ]]; then
  SHELL_PROFILE=$ZSHRC
elif [[ -f $PROFILE  ]]; then
  SHELL_PROFILE=$PROFILE
else
  touch $PROFILE
  SHELL_PROFILE=$PROFILE
fi;

pretty_echo -s "shell profile set to $SHELL_PROFILE"
pretty_echo -s "is this correct? [y/N]"
read IS_CORRECT
if [[ $IS_CORRECT =~ ^(n|N)$ ]]; then
  pretty_echo -s "please input full path to shell profile:"
  read CORRECT_SHELL
  SHELL_PROFILE=$CORRECT_SHELL
else
  pretty_echo -s "ok! continuing install ..."
fi

BITCOIND_CLI_INSTALL_FOLDER=$(dirname $0)
if [[ ! $PWD == $BITCOIND_CLI_INSTALL_FOLDER ]]; then
  cd $BITCOIND_CLI_INSTALL_FOLDER
fi

TEST_BITCOIND_CLI_REPO=$(cat $SHELL_PROFILE | grep BITCOIND_CLI_REPO=)
TEST_BITCOIND_CLI_MAN=$(cat $SHELL_PROFILE | grep BITCOIND_CLI_MAN=)
if [[ -z $TEST_BITCOIND_CLI_REPO ]]; then
  echo $'\n'"export BITCOIND_CLI_REPO=$PWD" >> $SHELL_PROFILE
fi

if [[ -z $TEST_BITCOIND_CLI_MAN ]]; then
  echo $'\n'"export BITCOIND_CLI_MAN_PAGE=$MAN_FILE_FOLER_PATH" >> $SHELL_PROFILE
fi

SHOW_HELP=$(echo "${ARGS[0]}" | tr -d -)

pretty_echo -s "installing bitcoind-cli ..."
cp $BITCOIND_CLI $LOCAL_BIN
pretty_echo -s "bitcoind-cli installed at $BITCOIND_CLI_PATH"

pretty_echo -s "Backing up bitcoind-cli ..."
if [[ ! -e $BACKUP_FOLDER ]]; then 
  mkdir $BACKUP_FOLDER
fi
cp $BITCOIND_CLI_PATH $BACKUP_FILE_FOLER_PATH
pretty_echo -s "bitcoind-cli backed up to $BACKUP_FILE_FOLER_PATH"

pretty_echo -s "installing bitcoind-cli manual page ..."
cp $MAN_FILE $LOCAL_MAN
pretty_echo -s "$MAN_FILE backed up to $LOCAL_MAN"

if [[ $SHOW_HELP =~ ^(h|H|help)$ ]]; then
  bitcoind-cli help
elif [[ -z $SHOW_HELP ]]; then
  pretty_echo -s "would you like to see the bitcoind-cli usage guide? [y|N]"
  read SHOW_HELP
  if [[ $SHOW_HELP =~ ^(y|Y) ]]; then
    man bitcoind-cli
  fi
  exit 0
else
  pretty_echo -s "for help with using the cli, run bitcoind-cli help"
  exit 0
fi
