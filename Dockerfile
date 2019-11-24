ARG RESOLVER
FROM docker.io/oprdyn/haskell:${RESOLVER} as build
ARG RESOLVER

#
# Make binary in build container
#

RUN stack build --resolver=${RESOLVER} \
        fingertree \
        hinotify \
        pandoc \
        terminal-size \
        typed-process \
 && cleanup

COPY tmp/unbeliever/. /src/unbeliever/
COPY tmp/publish/. /src/publish/
WORKDIR /src/publish
RUN stack install --resolver=${RESOLVER} --local-bin-path=/usr/local/bin \
 && cleanup

#
# Now make target container
#

FROM docker.io/oprdyn/debian:buster
RUN apt-get install \
        libgmp10 \
        zlib1g \
 && apt-get clean
COPY --from=build /usr/local/bin/render /usr/local/bin/
