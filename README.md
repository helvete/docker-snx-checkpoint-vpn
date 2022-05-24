# Docker SNX CheckPoint VPN

## Introduction

Client for Checkpoint VPN using snx GNU/Linux client.

This tool starts a VPN client in isolated environment.

* once a VPN tunnel is established a route is added to the host machine in order to route the VPN traffic
* named docker network is also being created; the purpose of this is, that other containers can join this network and reach resources through the tunnel

## Original [README]

Is [here](https://github.com/helvete/docker-snx-checkpoint-vpn/blob/master/README_original.md).

## Dependencies

* docker
* docker-compose
* [net-tols package](https://packages.debian.org/bullseye/net-tools) to be able to use `route` tool
* make

## How to

* Place your pkcs12 bundle under `./cert/` dir
* Fill up the `.env` file (don't forget to set the bundle file name and VPN host)
* Set up the subnet to be routed through the tunnel again within the `.env` file

## Usage

Once previously mentioned steps are satisfied, it suffices to run

* `make` to start the client
* `make stop` to stop it (and clean up)
