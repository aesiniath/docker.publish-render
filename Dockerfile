FROM oprdyn/haskell:lts-12.18 as build

#
# Make binary in build container
#

COPY tmp/unbeliever/. /src/unbeliever/
WORKDIR /src/unbeliever
RUN stack build --resolver=lts-12.18 --only-dependencies && cleanup
RUN stack install --resolver=lts-12.18 && cleanup

COPY tmp/publish/. /src/publish/
WORKDIR /src/publish
RUN stack build --resolver=lts-12.18 --only-dependencies && cleanup
RUN stack install --resolver=lts-12.18 --local-bin-path=/usr/local/bin && cleanup
