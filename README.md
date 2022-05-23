# Docker SNX CheckPoint VPN

## Introduction

Client for Checkpoint VPN using snx GNU/Linux client.

## Original [README]

Is [here](https://github.com/helvete/docker-snx-checkpoint-vpn/blob/master/README_original.md).

## How to

* Place your pkcs12 bundle under `./cert/` dir
* Fill up the `.env` file (don't forget to set the bundle file name and VPN host)
* Run `make` to build and run the VPN client
* Set up the subnet to be routed through the tunnel within `.env` file
