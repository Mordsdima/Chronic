module types

// Here is configuration for renderer

@[params]
pub struct RendererConfig {
pub:
	width  int
	height int
	title  string
}

pub enum MouseState {
	invalid
	left
	right
	middle
}

// And also here is interface of base renderer, render function will be later

pub interface Renderer {
mut:
	init(mut Context, RendererConfig) !
	init_app(mut App) !
	deinit() !
	mainloop(mut App, mut Context) !
	// render functions
	begin()
	end()
	set_bg_color(mut Color)
	load_image(string) !int
	unload_image(int) !
	draw_image(int, f32, f32) !
	draw_text(int, int, string) !
	draw_ctext(int, int, string, mut Color) !
	get_text_width(string) int
	get_text_height() int
	scissor(Rect)
	draw_rect(Rect, mut Color)
	get_mouse_x() i32
	get_mouse_y() i32
	get_mouse_s() MouseState
	begin_c2d(Camera2D) !
	get_dpi() f32
	get_res() (int, int)
}
