#!/bin/bash

# Zulip
# <https://inaudito.zulipchat.com/help/desktop-app-install-guide>

sudo apt-key adv --keyserver pool.sks-keyservers.net --recv 69AD12704E71A4803DCA3A682424BE5AE9BD10D9
echo "deb https://dl.bintray.com/zulip/debian/ stable main" | \
    sudo tee -a /etc/apt/sources.list.d/zulip.list
sudo aptitude update
sudo aptitude install -y zulip
