#!/usr/bin/env bash


STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.jsx\?$')
BIN_PATH="$(git rev-parse --show-toplevel)/node_modules/.bin"
JEST="$BIN_PATH/jest"


# Exit if no files modified
if [[ "$STAGED_FILES" = "" ]]; then
  exit 0
fi


# Check for eslint
if [[ ! -x "$JEST" ]]; then
  printf "\t\033[41mPlease install Jest\033[0m\n"
  exit 1
fi

echo "Testing related to modified files"

$JEST --bail --findRelatedTests $STAGED_FILES

if [[ $? == 0 ]]; then
  printf "\n\033[1;32mTest Passed\033[0m\n"
else
  printf "\n\033[41mTest Failed:\033[0m Fix test errors and try again!\n"
  exit 1
fi
