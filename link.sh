#!/bin/bash

set -e
set -o pipefail

DOTFILES="/home/ricardo/workspace/dotfiles"

function _show_help_and_exit() {
	echo -e "Linking your configuration files from ${DOTFILES} to their appropriate locations\n"
	echo -e "usage: ./link.sh [-s preferred_shell]"
	exit "${1}"
}

while getopts 'hs:' flag; do
	case "${flag}" in
		h) _show_help_and_exit 0;;
		s) user_shell="${OPTARGS:-fish}" ;;
		*) _show_help_and_exit 1;;
	esac
done

echo -e '\nCreating symlinks'
echo '========================='

linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
echo -e "Found linkable files:\n$linkables\n"
echo -e 'Linking...\n'
for file in $linkables ; do
	target="$HOME/.$( basename "$file" '.symlink' )"
	if [ -e "$target" ]; then
		echo "~${target#$HOME} already exists - skipping..."
	else 
		echo "Creating symlink for $file"
		ln -sf "$file" "$target" 
	fi
done

echo -e "Linking executables"
executables=$( find -H "$DOTFILES/bin" -name "*.sh" )
for ex in $executables; do
  target="/usr/local/bin/$(basename "$ex" '.sh')"
  ln -sf "$ex" "$target"
done
	
if [ "${user_shell}" == 'fish' ]; then
	echo -e 'Linking fish config files'
	mkdir -p "${HOME}/.config/fish"
        fish_config_source="${DOTFILES}/fish/config.fish"
	fish_config_target="${HOME}/.config/fish/config.fish"

	if [ -e "${fish_config_target}" ]; then
		echo -e "${fish_config_target#$HOME} already exists - skipping...\n"
	else
		echo -e "Creating symlink for ${fish_config_target#$HOME}"
		ln -s "${fish_config_source}" "${fish_config_target}"
	fi

	mkdir -p "$HOME/.config/fish/functions"
	functions=$( find -H "/Users/ricardo/Documents/workspace/dotfiles/fish/functions" )
	for func in ${functions}; do
		funcname=$(echo "${func}" | sed -E 's/^.*\///')
		target="$HOME/.config/fish/functions/${funcname}"
		if [ -e "$target" ]; then
			echo "~${target#$HOME} already exists - skipping..."
		else 
			echo "Creating symlink for $func"
			ln -s "$func" "$target" 
		fi
	done

        completions=$( find -H "$DOTFILES/fish/completions" -name "*.fish" )
        for comp in ${completions}; do
          target="$HOME/.config/fish/completions/$(basename "$comp")"
          ln -s "$comp" "$target"
        done
fi

