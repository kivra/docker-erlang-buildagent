FROM alpine:3.12.3

# Setup base packages and minimal alpine erlang image
RUN apk --update --upgrade add \
      autoconf \
      bsd-compat-headers \
      build-base \
      curl \
      dumb-init \
      file-dev \
      git \
      grep \
      ncurses-dev \
      ncurses-libs \
      openssh \
      openssl \
      openssl-dev \
      perl \
      sed \
      tzdata \
      wget \
      zip \
 && rm -rf /var/cache/apk/*

# Disable ipv6
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf

ENV LANG en_US.UTF-8

# Trust Github SSH fingerprint
ADD known_hosts /etc/ssh/ssh_known_hosts

WORKDIR /tmp/
COPY build_erlang.sh /tmp/
RUN sh ./build_erlang.sh

COPY build_rebar.sh /tmp/
RUN sh ./build_rebar.sh

COPY build_plt.sh /tmp/
RUN sh ./build_plt.sh

COPY build_elvis.sh /tmp/
RUN sh ./build_elvis.sh

WORKDIR /
CMD /bin/sh
