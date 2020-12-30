#!/bin/bash

set -ue

echo "Installing Rebar ..."

git clone https://github.com/erlang/rebar3.git
cd rebar3
git checkout 3.14.3
./bootstrap

mv rebar3 /usr/bin

# clean up
cd ..
rm -rf rebar3
