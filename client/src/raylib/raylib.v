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

// rtextures (need to be enabled in raylib)
pub struct C.Image {
pub:
	// there also a void *data but DONT EDIT IT MANUALLY, so its not included
	width i32
	height i32
	mipmaps i32 // how to bomb the pc? just set it to max of 32 bit int
	format i32
}

pub struct C.Texture {
pub:
	id u8 // do not edit manually!!
	width i32
	height i32
	mipmaps i32
	format i32
}

pub fn C.LoadTexture(file_name &char) C.Texture
pub fn C.DrawTexture(texture C.Texture, posX i32, posY i32, tint C.Color)

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