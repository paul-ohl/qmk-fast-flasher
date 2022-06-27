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

needed_dependencies=''

check_for_dependency() {
	if ! [[ "$(command -v "$1")" ]]; then
		echo "Dependency $1 missing!"
		needed_dependencies="$needed_dependencies $1"
	fi
}

check_for_dependency python3
check_for_dependency stow
check_for_dependency qmk

# Check if need to install qmk cli
if ! [[ "$needed_dependencies" = "" ]]; then
	printf "Some needed dependencies are missing, do you want to install them? (y/n)"
	read -r -d '' -sn1 user_input
	if ! [[ "$user_input" = 'y' ]]; then
		exit 1
	fi
	if [[ "$(command -v paru)" ]]; then
		paru -S $needed_dependencies
	elif [[ "$(command -v yay)" ]]; then
		yay -S $needed_dependencies
	elif [[ "$(command -v pacman)" ]]; then
		sudo pacman -S $needed_dependencies
	elif [[ "$(command -v brew)" ]]; then
		brew install $needed_dependencies
	elif [[ "$(command -v yum)" ]]; then
		sudo yum install $needed_dependencies
	elif [[ "$(command -v apt)" ]]; then
		sudo apt install git python3-pip stow
		python3 -m pip install --user qmk
		PATH="$HOME/.local/bin/:$PATH"
	fi
fi

# Check if need to clone repo
if ! [[ -e "$clone_location" ]]; then
	echo "installing qmk in $clone_location"
	qmk setup -H "$clone_location"
fi

script_directory=$(dirname "$0")

# Stow the directories
stow -d "$script_directory" -t "$clone_location/keyboards/" my_keymaps

# Select keyboard
selected_keyboard=''
select_option "$script_directory/my_keymaps/" "selected_keyboard"

# Select keymap
selected_keymap=''
select_option "$script_directory/my_keymaps/$selected_keyboard/keymaps/" "selected_keymap"

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
		rules_file="$script_directory/my_keymaps/$selected_keyboard/keymaps/$selected_keymap/rules.mk"
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
