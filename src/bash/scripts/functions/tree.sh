# File: tree.sh
# Description: Custom function to display directory structure using eza.

tree() {
  local args=(--tree --level=2)

  if [[ "$1" == "-m" ]]; then
    shift
    LC_ALL=C eza "${args[@]}" --color=never "$@"
  else
    eza "${args[@]}" --icons "$@"
  fi
}
