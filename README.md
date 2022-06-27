# QMK fast flasher

## ✨ Features

- Only store your own keymaps in your repo
- If you have multiple keymaps, the script will make you choose which one you
want to use before flashing
- Automatically installs dependencies if needed with brew, paru, yay, pacman,
yum or apt
- clones the qmk firmware in a convenient place (default: `$XDG_DATA_HOME`)
- Allows you to select bootloader

## ⚡️ Requirements

The requirements are automatically installed by the script so you don't really
need to worry about it.

- stow
- qmk
- git
- python3/pip3

## ⚙️  How to use

### Directory structure

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

### Variables

If you want to change where the qmk repository is cloned, change the
`clone_location` variable on line 6.

If you own multiple types of micro-controllers and regularly need to change your
bootloader, set the `multiple_bootloaders` variable to true. Then when you will
be asked to select a bootloader before flashing your keyboard.
**This part of the script will modify your `rules.mk` file, it is pretty safe
but always make backups!**

If you're not interested in this feature, set it to false.

When launching the script, if you have multiple keyboards, it will ask you to
select one, and if you have multiple keymaps, it will also ask you to select
one. The script will setup qmk accordingly and ask you if you want to flash your
keyboard.

### Tips

I added an alias to this script in my zshrc to quickly use it.

If you don't want to reconfigure which keyboard/keymap you want to use every
time, just set it with this script and then use the `qmk flash` command, it will
remember which keyboard-keymap combination you last used.

If you are on Ubuntu, the script will fix the `$PATH` bug for itself, but if you
want to use the `qmk` command, you will need to add `$HOME/.local/bin/` to your
`$PATH` like so: `export PATH="$HOME/.local/bin/:$PATH"`

## 🤨 Notes from the developer

This script obviously exists because I'm lazy.
I often change and reset my machines and I always need to reinstall qmk to
modify my keyboard macros, so this script does it for me.

Also I have a lily58 with a pro-micro on one side and an elite-c on the other
side, so I needed a way to switch bootloaders quickly.

This repo holds my personal keyboard config, I left it voluntarly as an example,
but feel free to check it out!
