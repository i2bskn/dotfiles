#!/bin/bash

# Golang default install libraries.
# - github.com/nfs/gocode => golang completion
# - github.com/golang/lint/golint => linter for golang
# - github.com/motemen/ghq => repository manager

if ! which go > /dev/null 2>&1; then
  echo "Not found: go" 1>&2
  exit 1
fi

if [ -z $GOPATH ]; then
  echo 'Not found: $GOPATH' 1>&2
  exit 1
fi

LIBRARIES=(
  github.com/nsf/gocode
  github.com/golang/lint/golint
  github.com/motemen/ghq
)

for lib in ${LIBRARIES[@]}; do
  echo "installing $lib"
  go get -u $lib
done
