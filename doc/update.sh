if [[ ${ARGS[0]} =~ ^(-q|--quick)$ ]]; then
  pretty_echo "installing bdcli ..."
  cp $BITCOIND_CLI $LOCAL_BIN
  pretty_echo "bdcli installed at $BITCOIND_CLI_PATH"
  exit 0
fi