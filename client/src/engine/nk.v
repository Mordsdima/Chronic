module engine

import engine.types
import engine.renderers

// Wraps nuklear into a simple API

#flag -I @VMODROOT/externals/include
#flag -D NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#include <nuklear.h>
//#include <sokol_nuklear.h>

@[heap]
pub struct Nuklear {
mut:
	renderer types.Renderer = renderers.NullRenderer{}
	isinited bool
}

pub fn (mut nk Nuklear) init(mut renderer types.Renderer) ! {
	if nk.isinited { return error("Nuklear is already initializated!") }
	
	nk.isinited = true
	nk.renderer = renderer

}

pub fn (mut nk Nuklear) begin() {
}

pub fn (mut nk Nuklear) end() {
}

pub fn (mut nk Nuklear) draw() ! {
}

pub fn (mut nk Nuklear) update() {
}

pub fn (mut nk Nuklear) begin_window() bool {
	return false
}

pub fn (mut nk Nuklear) end_window() {
}