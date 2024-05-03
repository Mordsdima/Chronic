module main

import raylib

fn main() {
	mut app := App{
		title: 'Chronical'
	}

	app.render_cb = app.render
	app.update_cb = app.update
	app.deinit_cb = app.deinit
	app.init_cb = app.init

	app.initialize()
	app.main_loop()
	app.deinitialize()
}

pub fn (mut app App) render() {
	raylib.begin_drawing()

	raylib.clear_background(C.Color{
		r: u8(0x64)
		g: u8(0x95)
		b: u8(0xed)
		a: u8(0xff)
	})

	raylib.end_drawing()
}

pub fn (mut app App) update() {
}

pub fn (mut app App) deinit() {
}

pub fn (mut app App) init() {
}
