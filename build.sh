#!/bin/bash -e

#git archive --prefix="unbeliever/" --output="unbeliever.tar.gz" --remote="~/src/oprdyn/unbeliever" HEAD
#git archive --prefix="publish/" --output="publish.tar.gz" --remote="~/src/oprdyn/publish" HEAD

#git clone ~/src/oprdyn/unbeliever tmp/
#git clone ~/src/oprdyn/publish tmp/

rsync -av --exclude=.git --exclude=.stack-work ~/src/oprdyn/unbeliever tmp
rsync -av --exclude=.git --exclude=.stack-work ~/src/oprdyn/publish tmp

docker build \
	--tag=afcowie/publish-render:latest \
	--network=proxy \
	.

