#!/bin/bash

# Golang default install libraries.

if ! which go > /dev/null 2>&1; then
  echo "Not found: go" 1>&2
  exit 1
fi

if [ -z $GOPATH ]; then
  echo 'Not found: $GOPATH' 1>&2
  exit 1
fi

LIBRARIES=(
  golang.org/x/tools/cmd/godoc
  golang.org/x/tools/cmd/goimports
  github.com/golang/lint/golint
  github.com/nsf/gocode
  github.com/pilu/fresh
)

for lib in ${LIBRARIES[@]}; do
  echo "installing $lib"
  go get -u $lib
done
