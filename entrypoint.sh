#!/bin/bash

sudo usermod -u $USER_ID developer
sudo groupmod -g $GROUP_ID developer

curl -L https://source.unsplash.com/random/1920x1080 -o /home/developer/.config/terminator/background.jpg 2>/dev/null

sudo chown -R developer:developer /home/developer

su -c "$@" -s /bin/bash developer
