#!{{bash_bin}}

set -o errexit -o nounset -o pipefail

# Get the full path to the directory where this script is located.
dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
runfiles_dir="${dir}/{target_name}.runfiles/{{repository_name}}"

ament_prefix_path="${runfiles_dir}/{{ament_prefix_path}}"

if [ -z ${LD_LIBRARY_PATH+x} ]; then
  export LD_LIBRARY_PATH="${runfiles_dir}"
else
  export LD_LIBRARY_PATH="${runfiles_dir}:${LD_LIBRARY_PATH}"
fi

if [ -z "${ament_prefix_path}" ]; then
  unset AMENT_PREFIX_PATH
  ${runfiles_dir}/{entry_point} "$@"
else
  AMENT_PREFIX_PATH="${ament_prefix_path}" ${runfiles_dir}/{entry_point} "$@"
fi
