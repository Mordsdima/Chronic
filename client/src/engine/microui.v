module engine

import engine.types

// Wraps micro ui into a simple API

#flag @VMODROOT/externals/source/microui.c
#flag -I @VMODROOT/externals/include
#include <microui.h>

pub struct C.mu_Context {
pub mut:
	text_width MUI_text_width
	text_height MUI_text_height
}

struct C.mu_BaseCommand { 
	@type int
	size int
}

struct C.mu_JumpCommand { 
	base C.mu_BaseCommand
	dst voidptr
}

struct C.mu_ClipCommand { 
	base C.mu_BaseCommand
	rect C.mu_Rect
}

struct C.mu_RectCommand { 
	base C.mu_BaseCommand
	rect C.mu_Rect
	color C.mu_Color
}

struct C.mu_TextCommand { 
	base C.mu_BaseCommand
	font C.mu_Font
	pos C.mu_Vec2
	color C.u_Color
	str []char
}

struct C.mu_IconCommand { 
	base C.mu_BaseCommand
	rect C.mu_Rect
	id int
	color C.mu_Color
}

union C.mu_Command { 
	@type int
	base C.mu_BaseCommand
	jump C.mu_JumpCommand
	clip C.mu_ClipCommand
	rect C.mu_RectCommand
	text C.mu_TextCommand
	icon C.mu_IconCommand
}

pub fn C.mu_init(&C.mu_Context)
pub fn C.mu_begin(&C.mu_Context)
pub fn C.mu_end(&C.mu_Context)

pub type MUI_text_width = fn(voidptr, &char, i32) i32
pub type MUI_text_height = fn(voidptr) i32

@[heap]
pub struct MicroUI {
mut:
	renderer types.Renderer
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