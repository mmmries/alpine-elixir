FROM alpine:3.7

MAINTAINER Michael Ries <michael@riesd.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2017-09-26 \
    LANG=en_US.UTF-8 \
    HOME=/root \
    PROJECT_ROOT=/opt/app \
    # Set this so that CTRL+G works properly
    TERM=xterm

# Install Erlang
RUN \
    mkdir -p ${PROJECT_ROOT} && \
    adduser -s /bin/sh -u 1001 -G root -h ${HOME} -S -D default && \
    chown -R 1001:0 ${PROJECT_ROOT} && \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache \
      erlang@edge erlang-dev@edge erlang-kernel@edge erlang-hipe@edge erlang-compiler@edge \
      erlang-stdlib@edge erlang-erts@edge erlang-syntax-tools@edge erlang-sasl@edge \
      erlang-crypto@edge erlang-public-key@edge erlang-ssl@edge erlang-tools@edge \
      erlang-inets@edge erlang-mnesia@edge erlang-odbc@edge erlang-xmerl@edge erlang-runtime-tools@edge \
      erlang-erl-interface@edge erlang-parsetools@edge erlang-asn1@edge erlang-eunit@edge elixir@edge

RUN mix local.rebar --force && mix local.hex --force

WORKDIR ${PROJECT_ROOT}

CMD ["/bin/sh"]
