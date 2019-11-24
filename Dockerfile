FROM docker.io/oprdyn/haskell:lts-13.25 as build

#
# Make binary in build container
#

RUN stack build --resolver=lts-13.25 \
        fingertree \
        hinotify \
        pandoc \
        terminal-size \
        typed-process \
 && cleanup

COPY tmp/unbeliever/. /src/unbeliever/
COPY tmp/publish/. /src/publish/
WORKDIR /src/publish
RUN stack install --resolver=lts-13.25 --local-bin-path=/usr/local/bin \
 && cleanup

#
# Now make target container
#

FROM docker.io/oprdyn/debian:stretch
RUN apt-get install \
        libgmp10 \
        zlib1g \
 && apt-get clean
COPY --from=build /usr/local/bin/render /usr/local/bin/
