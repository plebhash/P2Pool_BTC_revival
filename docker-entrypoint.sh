#!/usr/bin/env bash
set -e

# Default values (if not set by environment):
: "${PAYOUT_ADDRESS:=16VcStqURGEdHx5UEYazDxRRx5UGNFeE3u}"
: "${BITCOIN_RPC_USER:=username}"
: "${BITCOIN_RPC_PASSWORD:=password}"

# Create the Bitcoin configuration directory if it doesn't exist
BITCOIND_DATADIR=/root/.bitcoin
mkdir -p $BITCOIND_DATADIR

BITCOIND_CONF=$BITCOIND_DATADIR/bitcoin.conf
BITCOIN_RPC_USER=username
BITCOIN_RPC_PASSWORD=password

# Write out the bitcoin.conf file using environment variables
cat <<EOF > $BITCOIND_CONF
rpcuser=${BITCOIN_RPC_USER}
rpcpassword=${BITCOIN_RPC_PASSWORD}
rpcbind=0.0.0.0
prune=550
EOF

TMUX_SESSION="p2pool_btc_revival"

# todo: fetch $BITCOIN_SNAPSHOT_URL
# todo: unpack $BITCOIN_SNAPSHOT_TARBALL to $BITCOIND_DATADIR

BITCOIND_LOGS=$BITCOIND_DATADIR/debug.log
BITCOIND_CMD="./bitcoin-0.13.1/bin/bitcoind -daemon; sleep 5; tail -f $BITCOIND_LOGS"
BITCOIN_RPC_HOST="host.docker.internal"
BITCOIN_RPC_PORT=8332

#P2POOL_CMD="python run_p2pool.py --help"

# todo: loop checking getblockchaininfo.
P2POOL_CMD="sleep 5; python run_p2pool.py --bitcoind-config-path $BITCOIND_CONF --bitcoind-address $BITCOIN_RPC_HOST --bitcoind-rpc-port $BITCOIN_RPC_PORT -a $PAYOUT_ADDRESS"

# start new tmux session detached
tmux new-session -d -s "$TMUX_SESSION"

# run monerod in the first (default) pane
tmux send-keys -t "$TMUX_SESSION:0.0" "$BITCOIND_CMD" C-m

# split the window horizontally
tmux split-window -h -t "$TMUX_SESSION:0"

# run p2pool in second pane
tmux send-keys -t "$TMUX_SESSION:0.1" "$P2POOL_CMD" C-m

# attach to the tmux session
tmux attach -t "$TMUX_SESSION"