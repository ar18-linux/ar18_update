#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -e

read -s -p "foo:" foo2

cd "${script_dir}"

LD_PRELOAD=
echo "${foo2}" | sudo -S -k  rm -rf ./xfce_desktop_deployment

git clone https://github.com/ar18-linux/xfce_desktop_deployment.git

echo "${foo2}" | xfce_desktop_deployment/xfce_desktop_deployment/exec.sh