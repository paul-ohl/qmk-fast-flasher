#include QMK_KEYBOARD_H

enum layer_number {
  _BASE = 0,
  _LOWER,
  _RAISE,
  _ADJUST,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* BASE
 * .-----------------------------------------.                    .-----------------------------------------.
 * | ESC  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |CTLESC|   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------|       |    |  🔇   |------+------+------+------+------+------|
 * |shft-`|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShf-\|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE | RGUI | LCTRL|
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
 [_BASE] = LAYOUT(
  KC_ESC,      KC_1,   KC_2,    KC_3,    KC_4,    KC_5,                     KC_6,    KC_7,    KC_VOLU, KC_VOLD, KC_0,    KC_BSPC,
  KC_TAB,      KC_Q,   KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC,
LCTL_T(KC_ESC),KC_A,   KC_S,    KC_D,    KC_F,    KC_G,                     KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
 SFT_T(KC_GRV),KC_Z,   KC_X,    KC_C,    KC_V,    KC_B, KC_MUTE,  KC_MUTE,  KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, RSFT_T(KC_BSLS),
                            KC_LALT, KC_LGUI, MO(_LOWER), KC_SPC, KC_ENT, MO(_RAISE),KC_RGUI, KC_LCTL
),

/* LOWER
 * .-----------------------------------------.                    .-----------------------------------------.
 * | ESC  |      |      |      |      |      |                    |      |      |      |      |      | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  | DEL  | 
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |CTLESC|   !  |   @  |   #  |   $  |   %  |-------.    ,-------|   ^  |   &  |   *  |   (  |   )  |  '   |
 * |------+------+------+------+------+------|   [   |    |  ☀    |------+------+------+------+------+------|
 * |shft-`|      |      |      |      |      |-------|    |-------|   +  |   -  |   =  |   [  |   ]  |RShf-\|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_LOWER] = LAYOUT(
  _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______, 
  _______, KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                      KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______, 
  _______, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                   KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, _______, 
  _______, _______, _______, _______, _______,_______,_______,C(S(KC_PWR)),KC_PLUS,KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, _______,  
                             _______, _______, _______, _______, _______, _______, _______, _______
),

/* RAISE
 * .-----------------------------------------.                    .-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |   `  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |-------.    ,-------| Left | Down |  Up  |Right |      |  '   |
 * |------+------+------+------+------+------|   [   |    |  🔇   |------+------+------+------+------+------|
 * |  F7  |  F8  |  F9  | F10  | F11  | F12  |-------|    |-------|      |   _  |   +  |   {  |   }  |RShf-\|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
[_RAISE] = LAYOUT(
  _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______, _______, 
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                        KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______, 
  KC_F1,  KC_F2,    KC_F3,   KC_F4,   KC_F5,   KC_F6,                       KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, XXXXXXX, _______, 
  KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,   _______, _______,  XXXXXXX, KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, _______, 
                             _______, _______, _______,  _______, _______,  _______, _______, _______
),

/* ADJUST
 * .-----------------------------------------.                    .-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      | DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      | BOOT |      |      |      |      |                    |      |WHL DN|WHL UP|      | PAUSE| DEL  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |ACL2  | BTN2 | BTN3 | BTN1 |      |-------.    .-------| Vim-like mouse mouvements | ACL0 |  '   |
 * |------+------+------+------+------+------|       |    |  🔇   |------+------+------+------+------+------|
 * |      |      |      |CAPSWD|      |  >>  |-------|    |-------|  <<  |      |      |      |      |RShf-\|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *                   | LAlt | LGUI |LOWER | /Space  /       \Enter \  |RAISE |BackSP| RGUI |
 *                   |      |      |      |/       /         \      \ |      |      |      |
 *                   `----------------------------'           '------''--------------------'
 */
  [_ADJUST] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, QK_BOOT, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, KC_WH_U, KC_WH_D, XXXXXXX, KC_MPLY, XXXXXXX,
  XXXXXXX, KC_ACL2, KC_BTN2, KC_BTN3, KC_BTN1, XXXXXXX,                   KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_ACL0, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, CAPSWRD, XXXXXXX, KC_MPRV, XXXXXXX, _______, KC_MNXT, DT_DOWN, DT_UP,   DT_PRNT, XXXXXXX, XXXXXXX,
                             _______, _______, _______, _______, _______,  _______, _______, _______
  )
};

layer_state_t layer_state_set_user(layer_state_t state) {
  return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
}

#if defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
    [_BASE] =   { ENCODER_CCW_CW(KC_VOLU, KC_VOLD), }, // volume up/down
    [_LOWER] =  { ENCODER_CCW_CW(KC_BRIU, KC_VOLD), }, // brightness up/down
    [_RAISE] =  { ENCODER_CCW_CW(KC_VOLU, KC_VOLD), }, // volume up/down
    [_ADJUST] = { ENCODER_CCW_CW(KC_VOLU, KC_VOLD), }, // volume up/down
};
#endif

bool encoder_update_user(uint8_t index, bool clockwise) {
	if (get_highest_layer(layer_state|default_layer_state) > 0) {
		if (clockwise) {
			tap_code(KC_BRIU);
		} else {
			tap_code(KC_BRID);
		}
	} else {
		if (clockwise) {
			tap_code(KC_VOLU);
		} else {
			tap_code(KC_VOLD);
		}
	}
	return true;
}

//SSD1306 OLED update loop, make sure to enable OLED_ENABLE=yes in rules.mk
#ifdef OLED_ENABLE

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master())
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  return rotation;
}

// When you add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

bool oled_task_user(void) {
  if (is_keyboard_master()) {
    // If you want to change the display of OLED, you need to change here
    oled_write_ln(read_layer_state(), false);
    oled_write_ln(read_keylog(), false);
    oled_write_ln(read_keylogs(), false);
    //oled_write_ln(read_mode_icon(keymap_config.swap_lalt_lgui), false);
    //oled_write_ln(read_host_led_state(), false);
    //oled_write_ln(read_timelog(), false);
  } else {
    oled_write(read_logo(), false);
  }
    return false;
}
#endif // OLED_ENABLE
