module renderers

import engine
import log

struct NullRenderer {

}

pub fn (r NullRenderer) init(mut ctx engine.Context, c RendererConfig) ! {
	// Do nothing, its a NULL Renderer (no renderer at all)
	log.info("Initializated NULL Renderer")
}

pub fn (r NullRenderer) deinit(mut ctx engine.Context) ! {
	// Do nothing, its a NULL Renderer (no renderer at all)
	log.info("Deinitializated NULL Renderer")
}

pub fn (r NullRenderer) mainloop(mut eng engine.Engine, mut ctx engine.Context) {
	log.info("Mainloop of NULL Renderer")

	for {
		// I dont know what to do inside null render so
		eng.app.update(0, mut ctx) or { panic(err) }
		eng.app.draw(0, mut ctx) or { panic(err) }
	}
}