#!/bin/bash

set -ue

# create dummy project
rebar3 new app dummy
cd dummy

# run dialyzer on dummy project to generate base plt
rebar3 dialyzer

# clean up
cd ..
rm -rf dummy
