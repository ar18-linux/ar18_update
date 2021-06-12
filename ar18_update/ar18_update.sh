#!/bin/bash

# Script template version 2021-06-12.01
# Make sure some modification to LD_PRELOAD will not alter the result or outcome in any way
LD_PRELOAD_old="${LD_PRELOAD}"
LD_PRELOAD=
# Determine the full path of the directory this script is in
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
script_path="${script_dir}/$(basename "${0}")"
#Set PS4 for easier debugging
export PS4='${BASH_SOURCE[0]}:${LINENO}: '
# Determine if this script was sourced or is the parent script
if [ -z "${ar18_sourced_map+x}" ]; then
  declare -A -g ar18_sourced_map
fi
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  ar18_sourced_map["${script_path}"]=1
else
  ar18_sourced_map["${script_path}"]=0
fi
echo "sourced: ${ar18_sourced_map["${script_path}"]}" 
# Initialise exit code
if [ -z "${ar18_exit_map+x}" ]; then
  declare -A -g ar18_exit_map
fi
ar18_exit_map["${script_path}"]=0
# Get old shell option values to restore later
IFS=$'\n' shell_options=($(shopt -op))
# Set shell options for this script
set -o pipefail
set -eu
set -x
# Start of script

. "${script_dir}/vars"
if [ ! -v ar18_helper_functions ]; then rm -rf "/tmp/helper_functions_$(whoami)"; cd /tmp; git clone https://github.com/ar18-linux/helper_functions.git; mv "/tmp/helper_functions" "/tmp/helper_functions_$(whoami)"; . "/tmp/helper_functions_$(whoami)/helper_functions/helper_functions.sh"; cd "${script_dir}"; export ar18_helper_functions=1; fi
obtain_sudo_password

echo "${ar18_sudo_password}" | sudo -Sk rm -rf /tmp/ar18_update
mkdir -p /tmp/ar18_update

cd /tmp/ar18_update

git clone https://github.com/ar18-linux/xfce_desktop_deployment.git

echo "sourced: ${ar18_sourced_map["${script_path}"]}" 
. xfce_desktop_deployment/xfce_desktop_deployment/exec.sh
echo "sourced: ${ar18_sourced_map["${script_path}"]}" 

# End of script
# Restore old shell values
set +x
for option in "${shell_options[@]}"; do
  eval "${option}"
done
# Restore LD_PRELOAD
LD_PRELOAD="${LD_PRELOAD_old}"
# Return or exit depending on whether the script was sourced or not
echo "sourced: ${ar18_sourced_map["${script_path}"]}" 
if [ "${ar18_sourced_map["${script_path}"]}" = "1" ]; then
  return "${ar18_exit_map["${script_path}"]}"
else
  exit "${ar18_exit_map["${script_path}"]}"
fi
