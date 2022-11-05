#!/bin/bash

source install_cert.sh

trap 'echo stop && killall crond && exit 0' SIGTERM SIGINT

create_cert

crond -f -l 8
