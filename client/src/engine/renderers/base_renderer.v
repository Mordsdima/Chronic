module renderers

import engine

// Here is configuration for renderer

@[params]
pub struct RendererConfig {
pub:
	width int
	height int
}

// And also here is interface of base renderer, render function will be later

pub interface Renderer {
	init(mut engine.Context, RendererConfig) !
	deinit(mut engine.Context) !
	mainloop(mut engine.Engine, mut engine.Context) !

	
}

