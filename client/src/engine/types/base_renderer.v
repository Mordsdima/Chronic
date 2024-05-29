module types

// Here is configuration for renderer

@[params]
pub struct RendererConfig {
pub:
	width int
	height int
}

// And also here is interface of base renderer, render function will be later

pub interface Renderer {
mut:
	init(mut Context, RendererConfig) !
	deinit() !
	mainloop(App, mut Context) !

	// render functions

	begin()
	end()
}

