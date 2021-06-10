#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -e

read -s -p "foo:" foo2

echo "${foo2}" | sudo -Sk rm -rf /tmp/ar18_update
mkdir -p /tmp/ar18_update

cd /tmp/ar18_update

LD_PRELOAD=

git clone https://github.com/ar18-linux/xfce_desktop_deployment.git

echo "${foo2}" | xfce_desktop_deployment/xfce_desktop_deployment/exec.sh