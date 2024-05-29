module renderers

import engine.types
import gg
import gx
import log

pub struct GGRenderer {
mut:
	context &gg.Context = unsafe { nil }
	app &types.App = unsafe { nil }
	ctx &types.Context = unsafe { nil }
}

fn (mut r GGRenderer) frame(mut ctx gg.Context) {
	r.app.update(0, mut r.ctx) or { panic(err) }
	r.app.draw(0, mut r.ctx) or { panic(err) }
}

pub fn (mut r GGRenderer) init(mut ctx types.Context, c types.RendererConfig) ! {
	r.ctx = ctx

	r.context = gg.new_context(
		width: c.width
		height: c.height
	)

	log.info("Initializated GG Renderer")
}

pub fn (mut r GGRenderer) deinit() ! {
	log.info("Deinitializated GG Renderer")
}

pub fn (mut r GGRenderer) mainloop(app types.App, mut ctx types.Context) ! {
	log.info("Mainloop of GG Renderer")

	r.context.run()
}

// Renderer base is done, now render function

pub fn (mut r GGRenderer) begin() {
	r.context.begin()
}

pub fn (mut r GGRenderer) end() {
	r.context.end()
}