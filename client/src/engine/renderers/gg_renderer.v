module renderers

import engine.types
import gg
import log
import sokol.sapp
import time

@[heap]
pub struct GGRenderer {
mut:
	context &gg.Context    = unsafe { nil }
	app     types.App      = types.empty_app
	ctx     &types.Context = unsafe { nil }
}

fn (mut r GGRenderer) game_thread() {
	for {
		if r.context.frame != 0 {
			break
		}
	}
	mut last_called := i64(0)
	for {
		ups := int(0.5 + 1.0 / sapp.frame_duration()) * 2 // Updates Per Second

		interval := 1000 / ups

		cur_time := time.now().unix_milli()

		elapsed := cur_time - last_called

		if elapsed < interval {
			time.sleep((interval - elapsed) * 1000 * 1000)
		}

		r.app.update(f32(elapsed) / 1000.0, mut r.ctx) or { panic(err) }
		r.ctx.cs.update(f32(elapsed) / 1000.0, mut r.ctx) or { panic(err) }

		last_called = time.now().unix_milli()
	}
}

fn (mut r GGRenderer) render_thread(mut ctx gg.Context) {
	r.app.draw(f32(sapp.frame_duration()), mut r.ctx) or { panic(err) }
	r.ctx.cs.draw(f32(sapp.frame_duration()), mut r.ctx) or { panic(err) }
}

fn (mut r GGRenderer) init_fn(mut ctx gg.Context) {
	r.app.init(mut r.ctx) or { panic(err) }
}

pub fn (mut r GGRenderer) init(mut ctx types.Context, c types.RendererConfig) ! {
	r.ctx = ctx

	r.context = gg.new_context(
		width: c.width
		height: c.height
		window_title: c.title
		frame_fn: r.render_thread
		init_fn: r.init_fn
	)

	log.info('Initializated GG Renderer')
}

pub fn (mut r GGRenderer) deinit() ! {
	log.info('Deinitializated GG Renderer')
	r.context.quit()
}

pub fn (mut r GGRenderer) mainloop(mut app types.App, mut ctx types.Context) ! {
	log.info('Mainloop of GG Renderer')

	r.app = app

	spawn r.game_thread()
	r.context.run() // run game thread
}

// Renderer base is done, now render function

pub fn (mut r GGRenderer) begin() {
	r.context.begin()
}

pub fn (mut r GGRenderer) end() {
	r.context.end()
}

pub fn (mut r GGRenderer) set_bg_color(mut color types.Color) {
	r.context.set_bg_color(color.to_gx_color())
}

pub fn (mut r GGRenderer) load_image(image_file string) !int {
	mut img := r.context.create_image(image_file)!
	mut img_idx := r.context.cache_image(img)

	return img_idx
}

pub fn (mut r GGRenderer) unload_image(image int) ! {
	r.context.remove_cached_image_by_idx(image)
}

pub fn (mut r GGRenderer) draw_image(image int, x f32, y f32) ! {
	mut img := r.context.get_cached_image_by_idx(image)

	r.context.draw_image(x, y, img.width, img.height, img)
}

pub fn (mut r GGRenderer) draw_text(x int, y int, text string) ! {
	r.context.draw_text2(gg.DrawTextParams{
		x: x
		y: y
		text: text
	})
}

pub fn (mut r GGRenderer) draw_ctext(x int, y int, text string, mut color types.Color) ! {
	r.context.draw_text2(gg.DrawTextParams{
		x: x
		y: y
		text: text
		color: color.to_gx_color()
	})
}

pub fn (mut r GGRenderer) get_text_width(s string) int {
	return r.context.text_width(s)
}

pub fn (mut r GGRenderer) get_text_height() int {
	return r.context.text_height('abc')
}

pub fn (mut r GGRenderer) scissor(rect types.Rect) {
	r.context.scissor_rect(int(rect.x), int(rect.y), int(rect.w), int(rect.h))
}

pub fn (mut r GGRenderer) draw_rect(rect types.Rect, mut color types.Color) {
	r.context.draw_rect_empty(rect.x, rect.y, rect.w, rect.h, color.to_gx_color())
}

pub fn (mut r GGRenderer) get_mouse_x() i32 {
	return i32(r.context.mouse_pos_x)
}

pub fn (mut r GGRenderer) get_mouse_y() i32 {
	return i32(r.context.mouse_pos_y)
}

pub fn (mut r GGRenderer) get_mouse_s() types.MouseState {
	return types.MouseState(r.context.mouse_buttons)
}

pub fn (mut r GGRenderer) begin_c2d(camera types.Camera2D) ! {
}

pub fn (mut r GGRenderer) end_c2d() ! {
}

pub fn (mut r GGRenderer) get_dpi() f32 {
	return gg.dpi_scale()
}

pub fn (mut r GGRenderer) get_res() (int, int) {
	res := r.context.window_size()
	return res.width, res.height
}

pub fn (mut r GGRenderer) init_app(mut app types.App) ! {
	r.app = app
	// r.context.config.init_fn = r.init_fn
}
