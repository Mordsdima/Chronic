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
pub fn C.EndDrawing()
pub fn C.ClearBackground(color C.Color)

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

pub fn begin_drawing() {
	C.BeginDrawing()
}

pub fn end_drawing() {
	C.EndDrawing()
}

pub fn clear_background(color C.Color) {
	C.ClearBackground(color)
}
