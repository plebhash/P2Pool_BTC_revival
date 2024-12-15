#!/bin/bash

# build image
docker build -t p2pool_btc_revival .

# run image
docker run --env-file .env --rm -it p2pool_btc_revival
