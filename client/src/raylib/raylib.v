module raylib

// here raylib bindings (almost all****)

#flag @VMODROOT/raylib/src/libraylib.a
#flag -I @VMODROOT/externals/include
#flag -lm
#include <raylib.h>

pub struct C.Color {
pub mut: // i think it not should be mutable, but its can be edited
	r u8
	g u8
	b u8
	a u8
}

pub struct C.Vector2 {
pub mut:
	x f32
	y f32
}

pub struct C.Camera2D {
pub mut:
	offset   C.Vector2
	target   C.Vector2
	rotation f32
	zoom     f32
}

pub fn C.InitWindow(width int, height int, title &char)
pub fn C.SetTargetFPS(fps int)
pub fn C.WindowShouldClose() bool
pub fn C.CloseWindow()
pub fn C.BeginDrawing()
pub fn C.BeginMode2D(camera C.Camera2D)
pub fn C.EndMode2D()
pub fn C.EndDrawing()
pub fn C.ClearBackground(color C.Color)
pub fn C.IsKeyPressed(key i32) bool
pub fn C.IsKeyDown(key i32) bool

// rtextures (need to be enabled in raylib)
pub struct C.Image {
pub:
	// there also a void *data but DONT EDIT IT MANUALLY, so its not included
	width   i32
	height  i32
	mipmaps i32 // how to bomb the pc? just set it to max of 32 bit int
	format  i32
}

pub struct C.Texture {
pub:
	id      u8 // do not edit manually!!
	width   i32
	height  i32
	mipmaps i32
	format  i32
}

pub fn C.LoadTexture(file_name &char) C.Texture
pub fn C.DrawTexture(texture C.Texture, posX i32, posY i32, tint C.Color)
pub fn C.DrawTextureV(texture C.Texture, position C.Vector2, tint C.Color)

// Wrapper

pub fn init_window(width int, height int, title string) {
	C.InitWindow(width, height, title.str)
}

pub fn set_target_fps(fps i32) {
	C.SetTargetFPS(fps)
}

pub fn window_should_close() bool {
	return C.WindowShouldClose()
}

pub fn close_window() {
	C.CloseWindow()
}

pub fn begin_mode_2d(camera C.Camera2D) {
	C.BeginMode2D(camera)
}

pub fn end_mode_2d() {
	C.EndMode2D()
}

pub fn begin_drawing() {
	C.BeginDrawing()
}

pub fn end_drawing() {
	C.EndDrawing()
}

pub fn clear_background(color C.Color) {
	C.ClearBackground(color)
}

// wrapper for rtextures
pub fn load_texture(file_name string) C.Texture {
	return C.LoadTexture(file_name.str)
}

pub fn draw_texture(texture C.Texture, pos_x i32, pos_y i32, tint C.Color) {
	C.DrawTexture(texture, pos_x, pos_y, tint)
}

pub fn draw_texture_v(texture C.Texture, position C.Vector2, tint C.Color) {
	C.DrawTextureV(texture, position, tint)
}

pub fn is_key_pressed(key Keys) bool {
	return C.IsKeyPressed(i32(key))
}

pub fn is_key_down(key Keys) bool {
	return C.IsKeyDown(i32(key))
}

pub enum Keys {
	key_null          = 0 // Key: NULL, used for no key pressed
	// Alphanumeric keys
	key_apostrophe    = 39 // Key: '
	key_comma         = 44 // Key: ,
	key_minus         = 45 // Key: -
	key_period        = 46 // Key: .
	key_slash         = 47 // Key: /
	key_zero          = 48 // Key: 0
	key_one           = 49 // Key: 1
	key_two           = 50 // Key: 2
	key_three         = 51 // Key: 3
	key_four          = 52 // Key: 4
	key_five          = 53 // Key: 5
	key_six           = 54 // Key: 6
	key_seven         = 55 // Key: 7
	key_eight         = 56 // Key: 8
	key_nine          = 57 // Key: 9
	key_semicolon     = 59 // Key: ;
	key_equal         = 61 // Key: =
	key_a             = 65 // Key: A | a
	key_b             = 66 // Key: B | b
	key_c             = 67 // Key: C | c
	key_d             = 68 // Key: D | d
	key_e             = 69 // Key: E | e
	key_f             = 70 // Key: F | f
	key_g             = 71 // Key: G | g
	key_h             = 72 // Key: H | h
	key_i             = 73 // Key: I | i
	key_j             = 74 // Key: J | j
	key_k             = 75 // Key: K | k
	key_l             = 76 // Key: L | l
	key_m             = 77 // Key: M | m
	key_n             = 78 // Key: N | n
	key_o             = 79 // Key: O | o
	key_p             = 80 // Key: P | p
	key_q             = 81 // Key: Q | q
	key_r             = 82 // Key: R | r
	key_s             = 83 // Key: S | s
	key_t             = 84 // Key: T | t
	key_u             = 85 // Key: U | u
	key_v             = 86 // Key: V | v
	key_w             = 87 // Key: W | w
	key_x             = 88 // Key: X | x
	key_y             = 89 // Key: Y | y
	key_z             = 90 // Key: Z | z
	key_left_bracket  = 91 // Key: [
	key_backslash     = 92 // Key: '\'
	key_right_bracket = 93 // Key: ]
	key_grave         = 96 // Key: `
	// Function keys
	key_space         = 32 // Key: Space
	key_escape        = 256 // Key: Esc
	key_enter         = 257 // Key: Enter
	key_tab           = 258 // Key: Tab
	key_backspace     = 259 // Key: Backspace
	key_insert        = 260 // Key: Ins
	key_delete        = 261 // Key: Del
	key_right         = 262 // Key: Cursor right
	key_left          = 263 // Key: Cursor left
	key_down          = 264 // Key: Cursor down
	key_up            = 265 // Key: Cursor up
	key_page_up       = 266 // Key: Page up
	key_page_down     = 267 // Key: Page down
	key_home          = 268 // Key: Home
	key_end           = 269 // Key: End
	key_caps_lock     = 280 // Key: Caps lock
	key_scroll_lock   = 281 // Key: Scroll down
	key_num_lock      = 282 // Key: Num lock
	key_print_screen  = 283 // Key: Print screen
	key_pause         = 284 // Key: Pause
	key_f1            = 290 // Key: F1
	key_f2            = 291 // Key: F2
	key_f3            = 292 // Key: F3
	key_f4            = 293 // Key: F4
	key_f5            = 294 // Key: F5
	key_f6            = 295 // Key: F6
	key_f7            = 296 // Key: F7
	key_f8            = 297 // Key: F8
	key_f9            = 298 // Key: F9
	key_f10           = 299 // Key: F10
	key_f11           = 300 // Key: F11
	key_f12           = 301 // Key: F12
	key_left_shift    = 340 // Key: Shift left
	key_left_control  = 341 // Key: Control left
	key_left_alt      = 342 // Key: Alt left
	key_left_super    = 343 // Key: Super left
	key_right_shift   = 344 // Key: Shift right
	key_right_control = 345 // Key: Control right
	key_right_alt     = 346 // Key: Alt right
	key_right_super   = 347 // Key: Super right
	key_kb_menu       = 348 // Key: KB menu
	// Keypad keys
	key_kp_0          = 320 // Key: Keypad 0
	key_kp_1          = 321 // Key: Keypad 1
	key_kp_2          = 322 // Key: Keypad 2
	key_kp_3          = 323 // Key: Keypad 3
	key_kp_4          = 324 // Key: Keypad 4
	key_kp_5          = 325 // Key: Keypad 5
	key_kp_6          = 326 // Key: Keypad 6
	key_kp_7          = 327 // Key: Keypad 7
	key_kp_8          = 328 // Key: Keypad 8
	key_kp_9          = 329 // Key: Keypad 9
	key_kp_decimal    = 330 // Key: Keypad .
	key_kp_divide     = 331 // Key: Keypad /
	key_kp_multiply   = 332 // Key: Keypad *
	key_kp_subtract   = 333 // Key: Keypad -
	key_kp_add        = 334 // Key: Keypad +
	key_kp_enter      = 335 // Key: Keypad Enter
	key_kp_equal      = 336 // Key: Keypad =
	// Android key buttons
	key_back          = 4 // Key: Android back button
	// key_menu            = 82       // Key: Android menu button
	key_volume_up     = 24 // Key: Android volume up button
	key_volume_down   = 25 // Key: Android volume down button
}
