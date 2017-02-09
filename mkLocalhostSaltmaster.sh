#!/bin/bash

mkdir saltmaster
pushd saltmaster
wget https://raw.githubusercontent.com/chruck/jassalt/master/salt/saltmaster/init.sls
wget https://raw.githubusercontent.com/chruck/jassalt/master/salt/saltmaster/file_ignore.conf
popd
sudo salt-call --local --file-root=. state.sls saltmaster
