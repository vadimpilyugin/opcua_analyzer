#!/bin/bash

set -e

function debug_and_die {
    OUTPUT_PATH=$HOME/.zkg/testing/opcua_analyzer/clones/opcua_analyzer
    if [ -s $OUTPUT_PATH/zkg.test_command.stdout ]; then
	echo "zkg test command stdout"
	echo "-----------------------"
	cat $OUTPUT_PATH/zkg.test_command.stdout
    fi

    if [ -s $OUTPUT_PATH/zkg.test_command.stderr ]; then
	echo "zkg test command stderr"
	echo "-----------------------"
	cat $OUTPUT_PATH/zkg.test_command.stderr
    fi

    if [ -s $HOME/.zkg/logs/opcua_analyzer-build.log ]; then
	echo "zkg build command output"
	echo "-----------------------"
	cat $HOME/.zkg/logs/opcua_analyzer-build.log
    fi

    exit 1
}

export PATH="/opt/zeek/bin:/opt/zeek-nightly/bin:$PATH"

echo "Running zkg test..."
zkg test "$PWD" || debug_and_die
echo "Tests succeeded. Running zkg install..."
zkg install --force --skiptests "$PWD" || debug_and_die
echo "Install succeeded."

