#!/usr/bin/make -f
include .env

main: date start

start: removecontainer createimg addroute

stop: delroute removecontainer

restart: stop start

createimg:
	COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build --force-recreate -d

addroute: containerip
	sudo route add -net ${POLICY_SUBNET} gw ${SNX_DOCKER_IP}

delroute: containerip
	sudo route del -net ${POLICY_SUBNET} gw ${SNX_DOCKER_IP}

containerip:
	$(eval SNX_DOCKER_IP=$(shell docker inspect --format '{{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' snx-vpn))

removecontainer:
	(docker container inspect snx-vpn > /dev/null 2>&1 && docker container rm --force snx-vpn) || true

date:
	@date
