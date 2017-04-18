#!/bin/bash

mkdir saltmaster
pushd saltmaster
wget -N https://raw.githubusercontent.com/chruck/jassalt/master/salt/salt/master.sls
wget -N https://raw.githubusercontent.com/chruck/jassalt/master/salt/salt/file_ignore.conf
popd

mkdir musthaves
pushd musthaves
wget -N https://raw.githubusercontent.com/chruck/jassalt/master/salt/musthaves/git.sls
popd

mkdir bashrc
pushd bashrc
wget -N https://raw.githubusercontent.com/chruck/jassalt/master/salt/bashrc/init.sls
popd

wget -N https://raw.githubusercontent.com/chruck/jassalt/master/salt/salt/minion.sls

sudo salt-call --local --file-root=. state.sls saltmaster
