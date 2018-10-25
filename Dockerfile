FROM erlang:21.1-alpine

MAINTAINER Michael Ries <michael@riesd.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2018-10-25 \
    LANG=en_US.UTF-8 \
    HOME=/root \
    PROJECT_ROOT=/opt/app \
    # Set this so that CTRL+G works properly
    TERM=xterm \
    PATH=/elixir/bin:$PATH

# Install Erlang
RUN \
    mkdir elixir && \
    wget https://repo.hex.pm/builds/elixir/v1.7.4-otp-21.zip -O elixir/precompiled.zip && \
    cd elixir && \
    unzip precompiled.zip && \
    rm precompiled.zip && \
    cd .. && \
    mkdir -p ${PROJECT_ROOT} && \
    adduser -s /bin/sh -u 1001 -G root -h ${HOME} -S -D default && \
    chown -R 1001:0 ${PROJECT_ROOT}

RUN mix local.rebar --force && mix local.hex --force

WORKDIR ${PROJECT_ROOT}

CMD ["/bin/sh"]
