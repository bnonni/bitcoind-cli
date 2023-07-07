#!/usr/bin/env bash
VERSION="$(cat $PWD/version | awk -F ': ' '{print $2}')"
COMMAND="install"

OS=$(uname)
case $OS in
Darwin) LOCAL_BIN=/usr/local/bin ;;
Linux) LOCAL_BIN=/usr/bin ;;
*) manual_set_local_bin ;;
esac

ARGS=("$@")
SHOW_HELP=$(echo "${ARGS[0]}" | tr -d -)
CLEAN_SHELl=$(echo $SHELL | sed 's/\/[a-z]*\///g')

BASHRC="$HOME/.bashrc"
BASH_PROFILE="$HOME/.bash_profile"
ZSHRC="$HOME/.zshrc"
PROFILE="$HOME/.profile"

LOCAL_ETC="/usr/local/etc"
MAN_FILE_FOLDER_PATH="/usr/local/share/man/man1/bdcli.1"

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

sh $PWD/welcome.sh

pretty_echo -s "welcome to the bdcli installer!"

check_current_dir() {
  COMMAND="check_current_dir"
  BDCLI_INSTALL_FOLDER=$(dirname $0)
  if [[ ! $PWD == $BDCLI_INSTALL_FOLDER ]]; then
    cd $BDCLI_INSTALL_FOLDER
  fi
}

auto_set_profile() {
  COMMAND="auto_set_profile"
  case $1 in
  bash)
    SUCCESS=$(test -e $BASHRC && echo 1 || echo 0)
    SHELL_PROFILE=$BASHRC
    ;;
  zsh)
    SUCCESS=$(test -e $ZSHRC && echo 1 || echo 0)
    SHELL_PROFILE=$ZSHRC
    ;;
  *)
    SUCCESS=$(test -e $PROFILE && echo 1 || echo 0)
    touch $PROFILE
    SHELL_PROFILE=$PROFILE
    ;;
  esac

  if [[ $SUCCESS == 1 ]]; then
    pretty_echo -s "shell is set to: $1"
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
  echo "export SHELL_PROFILE=$SHELL_PROFILE"$'\n' >>$SHELL_PROFILE
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

# TODO: fix this
# check_env_vars() {
#   COMMAND="check_env_vars"
#   TEST_BDCLI_REPO=$(cat $SHELL_PROFILE | grep BDCLI_REPO=)
#   TEST_BDCLI_MAN=$(cat $SHELL_PROFILE | grep BDCLI_MAN_PAGE=)
#   if [[ -z $TEST_BDCLI_REPO ]]; then
#     echo "export BDCLI_REPO=$PWD"$'\n' >>$SHELL_PROFILE
#   fi
#   if [[ -z $TEST_BDCLI_MAN ]]; then
#     echo "export BDCLI_MAN_PAGE=$MAN_FILE_FOLDER_PATH"$'\n' >>$SHELL_PROFILE
#   fi
#   source $SHELL_PROFILE
#   pretty_echo -s "Added the following values to $SHELL_PROFILE:"
#   pretty_echo "export SHELL_PROFILE=$SHELL_PROFILE"
#   pretty_echo "BDCLI_REPO=$BDCLI_REPO"
#   pretty_echo "TEST_BDCLI_MAN=$TEST_BDCLI_MAN"
# }

install_bdcli() {
  pretty_echo -s "installing bdcli ..."
  if [[ ! -e $LOCAL_BIN ]]; then
    pretty_echo -s "bin path $LOCAL_BIN does not exist"
    pretty_echo -s "hint: looking for something like /usr/local/bin, /usr/bin"
    pretty_echo -s "please enter a path to a local bin dir:"
    read LOCAL_BIN
  fi
  cp $PWD/../bdcli $LOCAL_BIN/bdcli
  pretty_echo -s "bdcli installed at $LOCAL_BIN/bdcli"
}

backup_bdcli() {
  BACKUP_FOLDER=$LOCAL_ETC/bak
  BACKUP_FILE_FOLER_PATH=$BACKUP_FOLDER/bdcli-$VERSION.bak

  pretty_echo -s "Backing up bdcli ..."
  if [[ ! -e $BACKUP_FOLDER ]]; then
    mkdir $BACKUP_FOLDER
  fi
  cp $LOCAL_BIN/bdcli $BACKUP_FILE_FOLER_PATH
  pretty_echo -s "bdcli backed up to $BACKUP_FILE_FOLER_PATH"
}

install_bdcli_man() {
  pretty_echo -s "installing bdcli manual page ..."
  if [[ ! -e $MAN_FILE_FOLDER_PATH ]]; then
    pretty_echo -s "man path $MAN_FILE_FOLDER_PATH does not exist"
    pretty_echo -s "please enter a path to your local man1 dir"
    pretty_echo -s "hint: check /usr/local/share & look for something like /usr/local/share/man/man1:"
    read MAN_FILE_FOLDER_PATH
  fi
  cp $PWD/doc/bdcli.1 $MAN_FILE_FOLDER_PATH
  pretty_echo -s "$MAN_FILE installed to $MAN_FILE_FOLDER_PATH"
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


check_current_dir
auto_set_profile $CLEAN_SHELl
# check_env_vars
install_bdcli
backup_bdcli
prompt_show_help