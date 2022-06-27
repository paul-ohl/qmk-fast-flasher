#!/bin/bash
# Date: 2022/06/27
# Description: Sets up qmk to flash your keyboard

# Where you want the qmk firmware to be cloned, read README.md for warnings
clone_location="$HOME/.local/share/qmk_firmware"

# Check if need to install qmk cli
if ! [[ "$(command -v qmk)" ]]; then
	if [[ "$(command -v paru)" ]]; then
		paru -S qmk stow
	elif [[ "$(command -v yay)" ]]; then
		yay -S qmk stow
	elif [[ "$(command -v pacman)" ]]; then
		pacman -S qmk stow
	elif [[ "$(command -v yum)" ]]; then
		yum install qmk stow
	elif [[ "$(command -v apt)" ]]; then
		apt install git python3-pip stow
		python3 -m pip install --user qmk
	elif [[ "$(command -v brew)" ]]; then
		brew install qmk stow
	fi
fi

# Check if need to clone repo
if ! [[ -e "$clone_location" ]]; then
	echo "installing qmk in $clone_location"
	qmk setup -H "$clone_location"
fi

# Select keyboard
keyboard_list=$(ls -m "./my_keymaps/")
IFS=', ' read -ra keyboard_list <<< "$keyboard_list"
if [[ "${#keyboard_list[@]}" = "1" ]]; then
	selected_keyboard=${keyboard_list[0]}
else
	selected_keyboard="error"
	while [ "$selected_keyboard" = "error" ]; do
		echo "select the keyboard you want to configure qmk to use: "
		for (( i = 0; i < ${#keyboard_list[@]}; i++)); do
			echo "$((i + 1)): ${keyboard_list[$i]}"
		done
		read -r -d '' -sn1 selected_keyboard
		selected_keyboard="${keyboard_list[$((selected_keyboard - 1))]}"
		if [[ "$selected_keyboard" = "" ]]; then
			echo "Option does not exist, Ctrl-c to exit"
			selected_keyboard="error"
		fi
	done
fi

# Select keymap
keymap_list=$(ls -m "./my_keymaps/$selected_keyboard/keymaps/")
IFS=', ' read -ra keymap_list <<< "$keymap_list"
if [[ "${#keymap_list[@]}" = "1" ]]; then
	selected_keymap=${keymap_list[0]}
else
	selected_keymap="error"
	while [ "$selected_keymap" = "error" ]; do
		echo "select the keymap you want to configure qmk to use: "
		for (( i = 0; i < ${#keymap_list[@]}; i++)); do
			echo "$((i + 1)): ${keymap_list[$i]}"
		done
		read -r -d '' -sn1 selected_keymap
		selected_keymap="${keymap_list[$((selected_keymap - 1))]}"
		if [[ "$selected_keymap" = "" ]]; then
			echo "Option does not exist, Ctrl-c to exit"
			selected_keymap="error"
		fi
	done
fi

echo "Stowing your repos inside qmk firmware"
stow -t "$clone_location/keyboards/" my_keymaps

echo "Setting up qmk to use keymap located in: $clone_location/keyboards/$selected_keyboard/keymap/$selected_keymap/"
qmk config user.keyboard="$selected_keyboard"
qmk config user.keymap="$selected_keymap"

printf "Done! Flash your keyboard? (y/n)"
read -r -d '' -sn1 user_input
if [[ "$user_input" = 'y' ]]; then
	echo ""
	qmk flash
fi
