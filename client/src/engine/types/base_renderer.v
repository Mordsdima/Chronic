module types

// Here is configuration for renderer

@[params]
pub struct RendererConfig {
pub:
	width int
	height int
	title string
}

// And also here is interface of base renderer, render function will be later

pub interface Renderer {
mut:
	init(mut Context, RendererConfig) !
	deinit() !
	mainloop(mut App, mut Context) !

	// render functions

	begin()
	end()
	set_bg_color(mut Color)
	load_image(string) !int
	unload_image(int) !
	draw_image(int, f32, f32) !
}

