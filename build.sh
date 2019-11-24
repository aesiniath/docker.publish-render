#!/bin/bash -e

rsync -av --exclude=.git --exclude=.stack-work ~/src/oprdyn/unbeliever tmp
rsync -av --exclude=.git --exclude=.stack-work ~/src/oprdyn/publish tmp

RESOLVER=`head -1 RESOLVER`

docker build \
	--tag=docker.io/oprdyn/publish-render:latest \
	--network proxy \
	--build-arg RESOLVER=${RESOLVER} \
	.

