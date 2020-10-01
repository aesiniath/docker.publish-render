#!/bin/bash -e

rsync -av --exclude=.git --exclude=.stack-work ~/src/aesiniath/unbeliever tmp
rsync -av --exclude=.git --exclude=.stack-work ~/src/aesiniath/publish tmp

RESOLVER=`head -1 RESOLVER`

docker build \
	--tag=docker.io/aesiniath/publish-render:latest \
	--network proxy \
	--build-arg RESOLVER=${RESOLVER} \
	.

