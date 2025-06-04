#!/usr/bin/env bash
current_script_path="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

ncolors=$(tput colors) # if the terminal supports color, print in color, otherwise don't
if [[ -n "$ncolors" && "$ncolors" -gt 2 ]]; then
  echo -e "dotfiles are in \033[1;34m$current_script_path/\033[0m, stowing those to \033[1;34m$HOME/\033[0m."
else
  echo "dotfiles are in $current_script_path, stowing those to $HOME."
fi

stow --dir="$current_script_path" --target="$HOME" --verbose=5 .
