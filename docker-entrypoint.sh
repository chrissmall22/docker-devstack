#!/bin/bash

set -xe

# If user don't provide any command
# Run filebeat
if [[ "$1" == "" ]]; then
     # tail -f /opt/stack/logs/stack.sh.log
     /opt/devstack/stack.sh
else
    # Else allow the user to run arbitrarily commands like bash
    exec "$@"
fi
