module engine

import engine.types
import engine.renderers

// Wraps micro ui into a simple API

#flag @VMODROOT/externals/source/microui.c
#flag -I @VMODROOT/externals/include
#include <microui.h>

pub const (
	mu_command_clip = 2
	mu_command_rect = 3
	mu_command_text = 4
	mu_command_icon = 5
)

pub struct Mu_Vec2 {
pub mut:
	x i32
	y i32
}

pub struct Mu_Rect {
pub mut:
	x i32
	y i32
	w i32
	h i32 
}

pub struct Mu_Color {
pub mut:
	r u8
	g u8
	b u8
	a u8
}

pub struct C.mu_Rect {
pub mut:
	x i32
	y i32
	w i32
	h i32
}

pub struct C.mu_Context {
pub mut:
	text_width MUI_text_width
	text_height MUI_text_height
}

pub struct Mu_BaseCommand { 
pub mut:
	@type int
	size int
}

pub struct Mu_JumpCommand { 
pub mut:
	base Mu_BaseCommand
	dst voidptr
}

pub struct Mu_ClipCommand { 
pub mut:
	base Mu_BaseCommand
	rect Mu_Rect
}

pub struct Mu_RectCommand { 
pub mut:
	base Mu_BaseCommand
	rect Mu_Rect
	color Mu_Color
}

pub struct Mu_TextCommand { 
pub mut:
	base Mu_BaseCommand
	font voidptr
	pos Mu_Vec2
	color Mu_Color
	str [1]u8
}

pub struct Mu_IconCommand { 
pub mut:
	base Mu_BaseCommand
	rect Mu_Rect
	id int
	color Mu_Color
}

pub struct Mu_Command { 
pub mut:
	@type int
	base Mu_BaseCommand
	jump Mu_JumpCommand
	clip Mu_ClipCommand
	rect Mu_RectCommand
	text Mu_TextCommand
	icon Mu_IconCommand
}

pub fn C.mu_init(&C.mu_Context)
pub fn C.mu_begin(&C.mu_Context)
pub fn C.mu_end(&C.mu_Context)
pub fn C.mu_next_command(&C.mu_Context, &&Mu_Command) i32
pub fn C.mu_begin_window_ex(&C.mu_Context, &char, C.mu_Rect, i32) i32
pub fn C.mu_end_window(&C.mu_Context)
pub fn C.mu_rect(i32, i32, i32, i32) C.mu_Rect
pub fn C.mu_input_mousemove(&C.mu_Context, i32, i32)

pub type MUI_text_width = fn(voidptr, &char, i32) i32
pub type MUI_text_height = fn(voidptr) i32

@[heap]
pub struct MicroUI {
mut:
	renderer types.Renderer = renderers.NullRenderer{}
	ctx &C.mu_Context = unsafe { nil }
	isinited bool
}

pub fn (mut mui MicroUI) text_width(font voidptr, text &char, len i32) i32 {
	return i32(mui.renderer.get_text_width(unsafe { cstring_to_vstring(text) }))
}

pub fn (mut mui MicroUI) text_height(font voidptr) i32 {
	return i32(mui.renderer.get_text_height())
}

pub fn (mut mui MicroUI) init(mut renderer types.Renderer) ! {
	if mui.isinited { return error("MicroUI is already initializated!") }
	
	mui.isinited = true
	mui.renderer = renderer
	mui.ctx = &C.mu_Context{}
	C.mu_init(mui.ctx)
	

	mui.ctx.text_width = mui.text_width
	mui.ctx.text_height = mui.text_height
}

pub fn (mut mui MicroUI) begin() {
	C.mu_begin(mui.ctx)
}

pub fn (mut mui MicroUI) end() {
	C.mu_end(mui.ctx)
}

pub fn (mut mui MicroUI) draw() ! {
	// draw gui
	mut cmd := voidptr(0)
	for {
		if C.mu_next_command(mui.ctx, &(unsafe { &Mu_Command(cmd) })) == 0 {
			break
		}

		command := &(unsafe { &Mu_Command(cmd) })
		if command.@type == mu_command_clip {
			mui.renderer.scissor(types.Rect{
				x: command.clip.rect.x,
				y: command.clip.rect.y,
				w: command.clip.rect.w,
				h: command.clip.rect.h,
			})
		} else if command.@type == mu_command_rect {
			mui.renderer.draw_rect(types.Rect{
				x: command.rect.rect.x,
				y: command.rect.rect.y,
				w: command.rect.rect.w,
				h: command.rect.rect.h,
			}, mut types.Color{
				r: command.rect.color.r,
				g: command.rect.color.g,
				b: command.rect.color.b,
				a: command.rect.color.a
			})
		} else if command.@type == mu_command_text {
			println(command.text.str)
			/*mui.renderer.draw_text(command.text.pos.x, command.text.pos.y, cstring_to_vstring(command.text.str.data), mut types.Color{
				r: command.text.color.r,
				g: command.text.color.g,
				b: command.text.color.b,
				a: command.text.color.a
			})!*/
		}
	}
}

pub fn (mut mui MicroUI) update() {
	C.mu_input_mousemove(mui.ctx, mui.renderer.get_mouse_x(), mui.renderer.get_mouse_y())
}

pub fn (mut mui MicroUI) begin_window(title string, rect types.Rect) bool {
	return C.mu_begin_window_ex(mui.ctx, &char(title.str), C.mu_rect(rect.x, rect.y, rect.w, rect.h), 0) != 0
}

pub fn (mut mui MicroUI) end_window() {
	C.mu_end_window(mui.ctx)
}