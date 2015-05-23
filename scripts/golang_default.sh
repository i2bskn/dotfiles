#!/bin/bash

# Golang default install libraries.
# - github.com/nfs/gocode => golang completion
# - github.com/codegangsta/cli => utilities for command line application

set -e

if ! which go > /dev/null 2>&1; then
  echo "Not found: go"
  exit 1
fi

# Install packages
go get -u github.com/nsf/gocode
go get -u github.com/codegangsta/cli

