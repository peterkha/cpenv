#!/bin/bash

if (("$#" < "1")); then
  echo "Usage: $0 <starting sha>"
  exit 1
fi

git log --pretty=oneline --abbrev-commit $1..`git rev-parse --abbrev-ref HEAD` . | gitLogParse.awk

