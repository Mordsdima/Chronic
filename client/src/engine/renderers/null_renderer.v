module renderers

import engine.types
import log

pub struct NullRenderer {
}

pub fn (mut r NullRenderer) init(mut ctx types.Context, c types.RendererConfig) ! {
	// Do nothing, its a NULL Renderer (no renderer at all)
	log.info('Initializated NULL Renderer')
}

pub fn (mut r NullRenderer) deinit() ! {
	// Do nothing, its a NULL Renderer (no renderer at all)
	log.info('Deinitializated NULL Renderer')
}

pub fn (mut r NullRenderer) mainloop(mut app types.App, mut ctx types.Context) ! {
	log.info('Mainloop of NULL Renderer')

	for {
		// I dont know what to do inside null render so
		app.update(0, mut ctx) or { panic(err) }
		app.draw(0, mut ctx) or { panic(err) }
	}
}

// Renderer base is done, now render function

pub fn (mut r NullRenderer) begin() {
}

pub fn (mut r NullRenderer) end() {
}

pub fn (mut r NullRenderer) set_bg_color(mut color types.Color) {
}

pub fn (mut r NullRenderer) load_image(image_file string) !int {
	return 0
}

pub fn (mut r NullRenderer) unload_image(image int) ! {
}

pub fn (mut r NullRenderer) draw_image(image int, x f32, y f32) ! {
}
