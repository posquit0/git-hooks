#!/usr/bin/env bash

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.jsx\?$')
BIN_PATH="$(git rev-parse --show-toplevel)/node_modules/.bin"
ESLINT="$BIN_PATH/eslint"


# Exit if no files modified
if [[ "$STAGED_FILES" = "" ]]; then
  exit 0
fi


# Check for eslint
if [[ ! -x "$ESLINT" ]]; then
  printf "\t\033[41mPlease install ESLint\033[0m\n"
  exit 1
fi

echo "Linting modified files"

echo $STAGED_FILES | xargs $ESLINT

if [[ $? == 0 ]]; then
  printf "\n\033[1;32mLint Passed\033[0m\n"
else
  printf "\n\033[41mLint Failed:\033[0m Fix lint errors and try again!\n"
  exit 1
fi
