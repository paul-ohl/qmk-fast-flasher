# QMK firmware downloader

A simpler way to setup your boards with qmk.

You just have to fork this repo, and edit the keymap name you use inside the
`setup.sh` file (It's the first variable you'll see inside the file).

Then you have to replicate the place your keymap would be in inside the
`keymaps/` folder.

For example, if you have created a keymap for a Lily58, you would put it in:
`./keymaps/.local/share/qmk_firmware/keyboards/lily58/keymaps/your_keymap`.
You can put multiple keymaps and multiple boards this way.

The repo is already setup to use my name and keymaps so you can see an example.
