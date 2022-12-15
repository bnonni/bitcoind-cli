#!/usr/bin/env bash
VERSION="v0.0.3"
COMMAND="install"

OS=$(uname)
case $OS in
Darwin) LOCAL_BIN=/usr/local/bin ;;
Linux) LOCAL_BIN=/usr/bin ;;
*) manual_set_local_bin ;;
esac

ARGS=("$@")
SHOW_HELP=$(echo "${ARGS[0]}" | tr -d -)

BITCOIND_CLI=$PWD/bdcli
BITCOIND_CLI_PATH=$LOCAL_BIN/bdcli

BASHRC=~/.bashrc
BASH_PROFILE=~/.bash_profile
ZSHRC=~/.zshrc
PROFILE=~/.profile

LOCAL_ETC=/usr/local/etc
BACKUP_FOLDER=$LOCAL_ETC/bak
BACKUP_FILE=bdcli-$VERSION.bak
BACKUP_FILE_FOLER_PATH=$BACKUP_FOLDER/$BACKUP_FILE

LOCAL_MAN=/usr/local/share/man/man1
MAN_FILE=bdcli.1
MAN_FILE_FOLER_PATH=$LOCAL_MAN/$MAN_FILE

pretty_echo() {
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

echo '\033[38;5;208m---------------------------------------------------\033[0m'
echo '\033[38;5;208m|  _______   _______    ______   __        ______  |\033[0m'
echo '\033[38;5;208m| /       \ /       \  /      \ /  |      /      | |\033[0m'
echo '\033[38;5;208m| $$$$$$$  |$$$$$$$  |/$$$$$$  |$$ |      $$$$$$/  |\033[0m'
echo '\033[38;5;208m| $$ |__$$ |$$ |  $$ |$$ |  $$/ $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$    $$< $$ |  $$ |$$ |      $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$$$$$$  |$$ |  $$ |$$ |   __ $$ |        $$ |   |\033[0m'
echo '\033[38;5;208m| $$ |__$$ |$$ |__$$ |$$ \__/  |$$ |_____  _$$ |_  |\033[0m'
echo '\033[38;5;208m| $$    $$/ $$    $$/ $$    $$/ $$       |/ $$   | |\033[0m'
echo '\033[38;5;208m| $$$$$$$/  $$$$$$$/   $$$$$$/  $$$$$$$$/ $$$$$$/  |\033[0m'
echo '\033[38;5;208m---------------------------------------------------\033[0m'
echo ""

pretty_echo -s "welcome to the bdcli installer!"

check_current_dir() {
  COMMAND="check_current_dir"
  BITCOIND_CLI_INSTALL_FOLDER=$(dirname $0)
  if [[ ! $PWD == $BITCOIND_CLI_INSTALL_FOLDER ]]; then
    cd $BITCOIND_CLI_INSTALL_FOLDER
  fi
}

auto_set_profile() {
  COMMAND="auto_set_profile"

  case $CLEAN_SHELL in
  bash)
    SUCCESS=$(test -e $BASHRC && echo 1 || echo 0)
    SHELL_PROFILE=$BASHRC
    ;;
  zsh)
    SUCCESS=$(test -e $ZSHRC && echo 1 || echo 0)
    SHELL_PROFILE=$ZSHRC
    ;;
  *)
    SUCCESS=$(test -e $PROFILE && echo 1 || touch $PROFILE && echo 0)
    SHELL_PROFILE=$PROFILE
    ;;
  esac

  if [[ $SUCCESS -eq 1 ]]; then
    pretty_echo -s "shell is set to: $CLEAN_SHELL"
    pretty_echo -s "shell profile set to: $SHELL_PROFILE"
    pretty_echo -s "are these correct? [y/N]"
    read CORRECT_SHELL
    if [[ $CORRECT_SHELL =~ ^(n|N)$ ]]; then
      manual_set_profile
    fi
  else
    pretty_echo -s "failed to set shell profile"
    manual_set_profile
  fi
  echo $'\n'"export SHELL_PROFILE=$SHELL_PROFILE" >>$SHELL_PROFILE
  source $SHELL_PROFILE
}

manual_set_profile() {
  COMMAND="manual_set_profile"
  pretty_echo -s "please input name of shell [e.g. zsh/bash/etc.]:"
  read SHELL
  pretty_echo -s "please input full path to shell profile:"
  read SHELL_PROFILE
  pretty_echo -s "shell profile set to $SHELL_PROFILE"
}

check_env_vars() {
  COMMAND="check_env_vars"
  TEST_BITCOIND_CLI_REPO=$(cat $SHELL_PROFILE | grep BITCOIND_CLI_REPO=)
  TEST_BITCOIND_CLI_MAN=$(cat $SHELL_PROFILE | grep BITCOIND_CLI_MAN_PAGE=)
  if [[ -z $TEST_BITCOIND_CLI_REPO ]]; then
    echo $'\n'"export BITCOIND_CLI_REPO=$PWD" >>$SHELL_PROFILE
    source $SHELL_PROFILE
  fi
  if [[ -z $TEST_BITCOIND_CLI_MAN ]]; then
    echo "export BITCOIND_CLI_MAN_PAGE=$MAN_FILE_FOLER_PATH"$'\n' >>$SHELL_PROFILE
    source $SHELL_PROFILE
  fi
  pretty_echo -s "Added the following values to $SHELL_PROFILE:"
  pretty_echo "export SHELL_PROFILE=$SHELL_PROFILE"
  pretty_echo "BITCOIND_CLI_REPO=$BITCOIND_CLI_REPO"
  pretty_echo "TEST_BITCOIND_CLI_MAN=$TEST_BITCOIND_CLI_MAN"
}

install_bdcli() {
  pretty_echo -s "installing bdcli ..."
  if [[ ! -e $LOCAL_BIN ]]; then
    pretty_echo -s "man path $LOCAL_BIN does not exist"
    pretty_echo -s "please enter a path to your local man1 dir"
    pretty_echo -s "hint: check /usr/local, look for something like /usr/local/share/man/man1:"
    read LOCAL_BIN
  fi
  cp $BITCOIND_CLI $LOCAL_BIN
  pretty_echo -s "bdcli installed at $BITCOIND_CLI_PATH"
}

backup_bdcli() {
  pretty_echo -s "Backing up bdcli ..."
  if [[ ! -e $BACKUP_FOLDER ]]; then
    mkdir $BACKUP_FOLDER
  fi
  cp $BITCOIND_CLI_PATH $BACKUP_FILE_FOLER_PATH
  pretty_echo -s "bdcli backed up to $BACKUP_FILE_FOLER_PATH"
}

install_bdcli_man() {
  pretty_echo -s "installing bdcli manual page ..."
  if [[ ! -e $LOCAL_MAN ]]; then
    pretty_echo -s "man path $LOCAL_MAN does not exist"
    pretty_echo -s "please enter a path to your local man1 dir"
    pretty_echo -s "hint: check /usr/local, look for something like /usr/local/share/man/man1:"
    read LOCAL_MAN
  fi
  cp $MAN_FILE $LOCAL_MAN
  pretty_echo -s "$MAN_FILE installed to $LOCAL_MAN"
}

prompt_show_help() {
  if [[ $SHOW_HELP =~ ^(h|H|help)$ ]]; then
    bdcli help
  elif [[ -z $SHOW_HELP ]]; then
    pretty_echo -s "would you like to see the bdcli usage guide? [y|N]"
    read SHOW_HELP
    if [[ $SHOW_HELP =~ ^(y|Y) ]]; then
      bdcli help
    fi
    exit 0
  else
    pretty_echo -s "for help with using the cli, run bdcli help"
    exit 0
  fi
}

full_install() {
  check_current_dir
  auto_set_profile
  check_env_vars
  install_bdcli
  backup_bdcli
  prompt_show_help
}

full_install
