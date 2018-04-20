#!/bin/bash

##
# @file dockertest.sh
# @author Jas Eckard <jas@eckard.com>
#
# @section LICENSE
#
# (GPL license?)
#
# @section DESCRIPTION
#
# This file is ...

# Return codes:  1 = bad parameter(s)
#                2 = required parameter missing

readonly localDir="$(cd ${BASH_SOURCE[0]%/*} && pwd -P && cd - >/dev/null)"

# To get some debug output call this file like:
# DEBUG=true ./dockertest.sh ...

echoStderr() { echo "$@" 1>&2; }

if [[ 'x' == "x${DEBUG}" ]]; then
        # Make `debug' a no-op
        debug() { :; }
else
        debug() {
                echoStderr -n "DEBUG ${BASH_LINENO[*]}:  "
                echoStderr "$@"
        }
fi

# Usages:
#echo “regular stdout output”
#echoStderr “regular stderr output”
#debug “stderr output only seen when DEBUG set”

declare rc=0
declare optionA=0
declare optionB=bogus
declare REQUIRED
declare OPTIONAL=bogus
readonly isofile="sysresccd-20161103-4.9.0.iso"
readonly
isourl="https://build.funtoo.org/distfiles/sysresccd/${isofile}"

Usage()
{
        cat 1>&2 <<EOFUsage

Usage:  $0 [OPTION]... REQUIRED [OPTIONAL]

  -a, --optionA         Description
  -b, --optionB VAL     Desc that takes VAL
  -h, -?, --help        Display this help and exit

EOFUsage
        exit ${rc}
}  # Usage()

parseOptions()
{
        debug "Original args:  $@"

        local shortopts="h?" ; local longopts="help,"
        shortopts+="a"; longopts+="optionA,"
        shortopts+="b:"; longopts+="optionB:,"

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
                        -a|--optionA)
                                debug "-a used"
                                optionA=1
                                shift
                                ;;
                        -b|--optionB)
                                shift
                                if [[ -n "$1" ]]; then
                                        debug "-b used: $1";
                                        optionB=$1
                                        shift;
                                fi
                                ;;
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

        REQUIRED=$1
        OPTIONAL=$2

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

getISO()
{
        if [[ ! -f ${isofile} ]]; then
                wget ${isourl}
        fi
}

mountISO()
{
        mkdir -p mnt mnt2
        sudo modprobe loop
        sudo modprobe isofs
        sudo modprobe squashfs
        sudo mount -o loop ${isofile} mnt
        sudo mount -o loop mnt/sysrcd.dat mnt2
}

mkContainer()
{
        sudo tar -C mnt2 -c . | sudo docker import - sysresccd
}

parseOptions "$@"
verifyParams
getISO
mountISO
mkContainer
