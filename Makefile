#!/usr/bin/make -f
include .env

main: date run

build:
	DOCKER_BUILDKIT=1 docker build -f ./Dockerfile -t kedu/snx-vpn .

run: build drop createimg addroute

drop:
	(docker container stop snx-vpn && docker container rm snx-vpn) || true

stop: delroute drop

createimg:
	docker run --name snx-vpn \
		--cap-add=ALL \
		-v /lib/modules:/lib/modules \
		-e SNX_SERVER="${VPN_HOST}" \
		-e SNX_PASSWORD=\
		-v `pwd`/cert/certificate.p12:/certificate.p12 \
		-t \
		-d kedu/snx-vpn

addroute: containerip
	sudo route add -net ${POLICY_SUBNET} netmask ${POLICY_NETMASK} gw ${SNX_DOCKER_IP}

delroute: containerip
	sudo route del -net ${POLICY_SUBNET} netmask ${POLICY_NETMASK} gw ${SNX_DOCKER_IP}

containerip:
	$(eval SNX_DOCKER_IP=$(shell docker inspect --format '{{ .NetworkSettings.IPAddress }}' snx-vpn))

date:
	@date
