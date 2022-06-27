#!/bin/bash
# Date: 2022/06/27
# Description: Sets up qmk to flash your keyboard

# Where you want the qmk firmware to be cloned, read README.md for warnings
clone_location="$HOME/.local/share/qmk_firmware"
multiple_bootloaders="true"

# argument 1: Path to folder containing elements
# argument 2: name of variable to modify
select_option () {
	element_list=$(ls -m "$1")
	IFS=', ' read -ra element_list <<< "$element_list"
	if [[ "${#element_list[@]}" = "1" ]]; then
		selected_element=${element_list[0]}
	else
		selected_element="error"
		while [ "$selected_element" = "error" ]; do
			echo "select the ${2#selected_} you want to configure qmk to use: "
			for (( i = 0; i < ${#element_list[@]}; i++)); do
				echo "    $((i + 1)): ${element_list[$i]}"
			done
			read -r -d '' -sn1 selected_element
			selected_element="${element_list[$((selected_element - 1))]}"
			if [[ "$selected_element" = "" ]]; then
				echo "Option does not exist, Ctrl-c to exit"
				selected_element="error"
			fi
		done
	fi
	export "$2"="$selected_element"
}

# Check if need to install qmk cli
if ! [[ "$(command -v qmk)" ]]; then
	if [[ "$(command -v paru)" ]]; then
		paru -S qmk stow
	elif [[ "$(command -v yay)" ]]; then
		yay -S qmk stow
	elif [[ "$(command -v pacman)" ]]; then
		pacman -S qmk stow
	elif [[ "$(command -v brew)" ]]; then
		brew install qmk stow
	elif [[ "$(command -v yum)" ]]; then
		yum install qmk stow
	elif [[ "$(command -v apt)" ]]; then
		apt install git python3-pip stow
		python3 -m pip install --user qmk
	fi
fi

# Check if need to clone repo
if ! [[ -e "$clone_location" ]]; then
	echo "installing qmk in $clone_location"
	qmk setup -H "$clone_location"
fi

# Stow the directories
stow -t "$clone_location/keyboards/" my_keymaps

# Select keyboard
selected_keyboard=''
select_option "./my_keymaps/" "selected_keyboard"

# Select keymap
selected_keymap=''
select_option "./my_keymaps/$selected_keyboard/keymaps/" "selected_keymap"

echo "Setting up qmk to use keymap located in:" \
	"$clone_location/keyboards/$selected_keyboard/keymap/$selected_keymap/"
qmk config user.keyboard="$selected_keyboard"
qmk config user.keymap="$selected_keymap"

printf "Done! Flash your keyboard? (y/n)"
read -r -d '' -sn1 user_input
if [[ "$user_input" = 'y' ]]; then
	echo ""
	if [[ "$multiple_bootloaders" = "true" ]]; then
		selected_bootloader="error"
		while [ "$selected_bootloader" = "error" ]; do
			echo "select the bootloader you want to configure qmk to use: "
			echo "    1. Caterina (Pro-micro, LilyPadUSB, Arduino, Adafruit)"
			echo "    2. Qmk DFU (Elite-c)"
			echo "    3. Atmel DFU (ATmega boards)"
			read -r -d '' -sn1 selected_bootloader
			case "$selected_bootloader" in
				1) selected_bootloader='caterina';;
				2) selected_bootloader='qmk-dfu';;
				3) selected_bootloader='atmel-dfu';;
				*)
					echo "Option does not exist, Ctrl-c to exit"
					selected_bootloader="error";;
			esac
		done
		rules_file="./my_keymaps/$selected_keyboard/keymaps/$selected_keymap/rules.mk"
		if grep BOOTLOADER "$rules_file" > /dev/null; then
			sed "s/BOOTLOADER.*/BOOTLOADER = $selected_bootloader/" \
				"$rules_file" > "$rules_file.tmp"
			mv "$rules_file.tmp" "$rules_file"
		else
			echo "# Added by flashqmk script, bootloader information" \
				>> "$rules_file"
			echo "BOOTLOADER = $selected_bootloader" >> "$rules_file"
		fi
	fi
	qmk flash
fi
