# QMK flasher

## ✨ Features

- Only store your own keymaps in your repo
- If you have multiple keymaps, the script will make you choose which one you
want to use before flashing
- Automatically installs dependenciesqmk if needed with brew, paru, yay, pacman,
yum or apt
- clones the qmk firmware in a convenient place (`$XDG_DATA_HOME`)

## ⚡️ Requirements

The requirements are automatically installed by the script.

- stow
- qmk
- git
- python3/pip3

## ⚙️  How to use

The `my_keymaps` directory replicates the directory structure of qmk's keyboard
folder. So you just have to create the right folders corresponding to your
keyboard(s) and keymap(s).

example with a keyboard called 'Lily58' and a keymap called
'my\_awesome\_keymap':
```
./my_keymaps
└─ lily58
   └─ keymaps
      └─ my_awesome_keymap
         ├── config.h
         ├── keymap.c
         └── rules.mk
```

The script uses `stow` to generate the folders inside the qmk repo, so if you
have a doubt, just
[read the manual](https://www.gnu.org/s/stow/manual/stow.html).

If you want to change where the qmk repository is cloned, just change the
`clone_location` variable on line 6, it is the only thing you should want to
change.

When launching the script, if you have multiple keyboards, it will ask you to
select one, and if you have multiple keymaps, it will also ask you to select
one. The script will setup qmk accordingly and ask you if you want to flash your
keyboard.

## 🤨 Why

This script obviously exists because I'm lazy.
I often change and reset my machines and I always need to reinstall qmk to
modify my keyboard macros, so this script does it for me.

Other reasons:
- Don't need to remember the syntax to select a keyboard and a keymap when
switching keyboards.
- The script allows you to select whether you want to compile for a pro-micro or
an elite-c
