#!/usr/bin/env bash

install_bundle() {
  rbenv which bundler
  if ! [ $? -eq 0 ]; then
    gem install bundler -v 2.0.1
  fi
}

install_gems() {
  bundle check || bundle install
}

cd "$(dirname "$0")/.." || exit

source script/helpers.sh

task_inform "Bootstrapping Dependencies..."

task_inform "Run \`tail -f $LOGFILE\` if you want to follow along."

subtask_exec "Installing Ruby Version" rbenv install -s "$(cat .ruby-version)"

subtask_exec "Installing Bundler" install_bundle

subtask_exec "Installing Gem dependencies" install_gems
