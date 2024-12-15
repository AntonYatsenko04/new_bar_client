#!/bin/bash

# run function in all dirs
# expects a function name
allDirs() {
  dirs=()
  while IFS= read -r line; do
    dirs+=("$line")
  done < <(find . -maxdepth 2 -type d)
  for dir in "${dirs[@]}"; do
    $1 "$dir"
  done
}

runGet() {
  cd "$1" || return
  if [ -f "pubspec.yaml" ]; then
    flutter clean && flutter pub get
  fi
  cd - >/dev/null || return
}

flutter clean

allDirs "runGet"