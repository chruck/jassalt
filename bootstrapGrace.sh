#!/bin/bash

##
# @file bootstrapGrace.sh
# @author Jas Eckard <jas@eckard.com>
#
# @section LICENSE
#
# GPL license
#
# @section DESCRIPTION
#
# Script to use system `grace' as a bootstrapped system to get
# everything going.
#
# Assumptions:
# * grace is a bare Bodhi Linux system
#   * therefore, package manager is apt
# * grace will be a minion to itself first, until another master is
#   built
#
# Return codes:  1 = bad parameter(s)
#                2 = required parameter missing

readonly localDir="$(cd ${BASH_SOURCE[0]%/*} && pwd -P && cd - >/dev/null)"

# To get some debug output call this file like:
# DEBUG=true ./bootstrapGrace.sh ...

echoStderr() { echo "$@" 1>&2; }

if [[ 'x' == "x${DEBUG}" ]]; then
        # Make `debug' a no-op
        debug() { :; }
else
        debug() {
                echoStderr -n "DEBUG:  "
                echoStderr "$@"
        }
fi

# Usages:
#echo “regular stdout output”
#echoStderr “regular stderr output”
#debug “stderr output only seen when DEBUG set”

declare rc=0
#declare optionA=0
#declare optionB=bogus
#declare REQUIRED
#declare OPTIONAL=bogus
declare MASTER="grace"
#readonly pi="3.1415"

Usage()
{
        cat 1>&2 <<EOFUsage

Usage:  $0 [OPTION]... #REQUIRED [MASTER]

#  -a, --optionA         Description
#  -b, --optionB VAL     Desc that takes VAL
  -h, -?, --help        Display this help and exit

EOFUsage
        exit ${rc}
}  # Usage()

parseOptions()
{
        debug "Original args:  $@"

        local shortopts="h?" ; local longopts="help,"
#        shortopts+="a"; longopts+="optionA,"
#        shortopts+="b:"; longopts+="optionB:,"

        debug "shortopts=${shortopts} longopts=${longopts}"

        ARGS=$(getopt -o "${shortopts}" -l "${longopts}" -n "getopt.sh" -- "$@")

        getoptRc=$?
        if [[ 0 -ne "${getoptRc}" ]]; then
                echoStderr "ERROR:  getopt called incorrectly, rc=${getoptRc}"
                rc=1
                exit ${rc}
                # Alternatively, ($rc gets passed):
                #Usage
        fi

        eval set -- "${ARGS}"

        while true; do
                param=$1
                case "${param}" in
#                        -a|--optionA)
#                                debug "-a used"
#                                optionA=1
#                                shift
#                                ;;
#                        -b|--optionB)
#                                shift
#                                if [[ -n "$1" ]]; then
#                                        debug "-b used: $1";
#                                        optionB=$1
#                                        shift;
#                                fi
#                                ;;
                        -h|-\?|--help)
                                debug "Asked for help"
                                Usage
                                ;;
                        --)
                                shift;
                                break;
                                ;;
                        *)
                                echoStderr "ERROR:  Unimplemented option: ${param}"
                                break;
                                ;;
                esac
        done

        debug "New args:  $@"

#        # For 1 required and one optional argument
#        if [[ 1 != ${#@} && 2 != ${#@} ]]; then
#                rc=2
#                echoStderr "ERROR:  REQUIRED required."
#        fi

#        REQUIRED=$1
#        OPTIONAL=$2
        MASTER=${1:-${MASTER}}

#        if [[ 'bogus' == "${optionB}" ]]; then
#                rc=2
#                echoStderr "ERROR:  --optionB field required."
#        fi

        if [[ 0 != ${rc} ]]; then
                Usage
        fi
}  # parseOptions()

# TODO:  Verify the parameters passed are valid
verifyParams()
{
        :
#       if [[ "${optionB}" =~ /reg[ex]/ ]]; then
#               echoStderr "ERROR:  --optionB should be of the form: reg[ex]"
#               rc=2
#       fi
}  # verifyParams()

#        while read line; do
#                echoStderr "WARNING:  I do not like ${line}"
#        done < <(grep "^${softwarebom}" ${steutabFName})

setupIptables()
{
        # IPTables on a bare system is blank, so this is not needed:
        # (but we want to enable it anyway for this master)
        sudo iptables -A INPUT -m state --state new -m tcp -p tcp --dport 4505 -j ACCEPT
        sudo iptables -A INPUT -m state --state new -m tcp -p tcp --dport 4506 -j ACCEPT
}  # setupIptables()

updateOS()
{
        echo "== First, make sure OS is up-to-date =="
        sudo apt update && sudo apt -y upgrade
}  # updateOS()

installSalt()
{
        case "${1}" in
                apt)
                        echo "== Install salt-master package =="
                        sudo apt install -y salt-master salt-minion salt-doc
                        ;;

                bootstrap)
                        # If, instead, I want the latest salt (I don't,
                        # since Bodhi is now installing 2014.7.2 of salt)
                        echo "== Uninstalling any previous salt packages =="
                        sudo apt purge -y salt-master salt-minion salt-doc \
                                          salt-ssh salt-cloud salt-common \
                                          salt-syndic

                        echo "== Install curl and git to bootstrap SaltStack =="
                        sudo apt install -y git curl
 
                        echo "== Download and execute SaltStack Bootstrap =="
                        curl -L http://bootstrap.saltstack.org | sudo sh -s --
                        ;;
                *)
                        echo "== installSalt() needs an argument, exiting =="
                        exit 2
        esac
}  # installSalt()

masterIsLocal()
{
        echo "== Create hostname 'salt' as alias to localhost =="
        sudo sed -i "s/127.0.0.1.*/& salt/" /etc/hosts 
}  # masterIsLocal()

startDaemons()
{
        echo "== Starting daemons =="
        sudo service salt-master restart
        sudo service salt-minion restart
}  # startDaemons()

acceptSaltkey()
{
        echo "== Accepting ${MASTER} =="
        sudo salt-key -ya ${MASTER}
}  # acceptSaltkey()

checkoutStates()
{
        echo "== Checking out salt states =="
        pushd /srv
        sudo git clone https://github.com/chruck/jassalt.git
        sudo ln -s jassalt/salt .
        sudo ln -s jassalt/pillar .
        popd
}  # checkoutStates()

deploy()
{
        echo "== Now deploy to ${MASTER} =="
        sudo salt "${MASTER}" state.highstate
}

parseOptions "$@"
verifyParams
setupIptables
updateOS
#installSalt apt
installSalt bootstrap
echo masterIsLocal
echo startDaemons
echo acceptSaltkey
echo checkoutStates
echo deploy
