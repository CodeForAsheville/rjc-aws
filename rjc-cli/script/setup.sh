#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit

# shellcheck disable=SC1091
source script/helpers.sh

script/bootstrap.sh || exit

task_inform "Setting up rjc_action_network..."

subtask_exec "Rehashing RBenv" rbenv rehash

task_inform "Cleaning up..."

subtask_exec "Cleaning up tmp log" rm "$LOGFILE"

task_inform "Checking setup..."

echo ""
echo "rjc_action_network is set up."
echo "Run \`bundle exec exe/rjc version\` from the command line to see something like this:"
bundle exec exe/rjc version

echo ""
echo "To run the rjc_action_network locally from source anywhere on your computer, add an alias to your shell:"
echo "alias myrjc=\"RBENV_VERSION=\$(cat \$HOME/src/www/rjc_action_network/.ruby-version) BUNDLE_GEMFILE=\$HOME/src/www/rjc_action_network/Gemfile bundle exec \$HOME/src/www/rjc_action_network/exe/rjc\""
