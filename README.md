<h1 align="center">
  <br>
  <img width="200" src="P2Pool_BTC_revival.png">
  <br>
P2Pool BTC revival
<br>
</h1>

<p align="center">
</p>

`P2Pool` is a protocol for decentralized pooled mining of blockchains.

the protocol is [alive and well on Monero](https://p2pool.io)... and why not on Bitcoin???

this repo aims to provide an automated way to easily deploy [`P2Pool`](http://p2pool.in/) for Bitcoin mining.

it automates the deployment of:
- [`P2Pool v17.0`](https://github.com/p2pool/p2pool/releases/tag/17.0)
- [`bitcoin core v0.13.1`](https://bitcoincore.org/bin/bitcoin-core-0.13.1)

# prerequisites

- `x86-64` system
- Docker

# instructions

## clone

```shell
$ git clone https://github.com/plebhash/P2Pool_btc_revival
$ cd P2Pool_btc_revival
```

## run

the `.env` file contains important variables:
- `PAYOUT_ADDRESS`: defaults to `16VcStqURGEdHx5UEYazDxRRx5UGNFeE3u`
- `BITCOIN_SNAPSHOT_URL`: defaults to xxx todo xxx
- `BITCOIN_SNAPSHOT_TARBALL`: defaults to xxx todo xxx

⚠️ note: `PAYOUT_ADDRESS` should contain an address you control.

⚠️ note: `PAYOUT_ADDRESS` MUST contain legacy addresses.

⚠️ note: `BITCOIN_SNAPSHOT_URL` + `BITCOIN_SNAPSHOT_TARBALL` should contain a snapshot from a source you trust.

```shell
$ ./P2Pool_btc_revival.sh
```

running the script above will build and run a Docker image which will give the user a [`tmux`](https://github.com/tmux/tmux) session with the following panes:
- logs of a running `bitcoind` node, where IBD was accelerated via snapshot
- `P2Pool` (only after `bitcoind` has finished IBD)

⚠️ note: you should replace `BITCOIN_SNAPSHOT_URL` + `BITCOIN_SNAPSHOT_TARBALL` on `.env` with your own trusted snapshot!

⚠️ note: you can use `generate_snapshot.sh` script to create your own snapshot from a synced `bitcoind v0.13.1`.

# roadmap

- [x] `Dockerfile`
- [x] `docker-entrypoint.sh`
- [x] `P2Pool_BTC_revival.sh`
- [ ] IBD snapshot