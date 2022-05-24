#!/usr/bin/make -f
include .env

main: date run

run: drop createimg addroute

drop:
	(docker container stop snx-vpn && docker container rm snx-vpn) || true

stop: delroute drop

createimg:
	COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up --build --force-recreate -d

addroute: containerip
	sudo route add -net ${POLICY_SUBNET} gw ${SNX_DOCKER_IP}

delroute: containerip
	sudo route del -net ${POLICY_SUBNET} gw ${SNX_DOCKER_IP}

containerip:
	$(eval SNX_DOCKER_IP=$(shell docker inspect --format '{{range .NetworkSettings.Networks }}{{.IPAddress}}{{end}}' snx-vpn))

date:
	@date
