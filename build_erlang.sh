#!/bin/bash

set -ue

echo "Installing Erlang ..."

ERLANG=erlang
OTP_VERSION=23.2
OTP_PACKAGE=OTP-$OTP_VERSION
OTP_ARCHIVE=$OTP_PACKAGE.tar.gz
OTP_DOWNLOAD=https://github.com/erlang/otp/archive/$OTP_ARCHIVE
OTP_COMPILE_FLAGS='--enable-m64-build --enable-dirty-schedulers --with-ssl --without-odbc --enable-smp-support --enable-threads --enable-kernel-poll'

mkdir -p $ERLANG
cd $ERLANG
  curl -sSLO $OTP_DOWNLOAD
  tar xfz $OTP_ARCHIVE

cd otp-$OTP_PACKAGE
  export ERL_TOP=`pwd`
  ./otp_build autoconf
  ./configure --enable-m64-build \
    --enable-hipe \
    --enable-threads \
    --enable-kernel-poll \
    --enable-smp-support \
    --enable-shared-zlib \
    --enable-dirty-schedulers \
    --enable-ssl=dynamic-ssl-lib \
    --with-ssl \
    --without-wx \
    --without-odbc \
    --without-javac \
    --without-debugger \
    --without-observer \
    --without-jinterface \
    --without-cosEvent\
    --without-cosEventDomain \
    --without-cosFileTransfer \
    --without-cosNotification \
    --without-cosProperty \
    --without-cosTime \
    --without-cosTransactions \
    --without-erl_docgen \
    --without-et \
    --without-gs \
    --without-ic \
    --without-megaco \
    --without-orber \
    --without-percept \
    --without-typer
  make -j4
  make install

echo "- done."
