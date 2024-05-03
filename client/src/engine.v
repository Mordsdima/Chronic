module main

import raylib

type InitFunction = fn ()

type DeinitFunction = fn ()

type RenderFunction = fn ()

type UpdateFunction = fn ()

// const default_handler = fn() {}

@[heap]
pub struct App {
pub:
	width  int    = 800
	height int    = 600
	title  string = '(empty)'
pub mut:
	render_cb RenderFunction = fn () {}
	update_cb UpdateFunction = fn () {}
	init_cb   InitFunction   = fn () {}
	deinit_cb DeinitFunction = fn () {}
}

pub fn (mut app App) initialize() {
	// We here initializating the raylib and then, init_cb

	raylib.init_window(app.width, app.height, app.title)

	app.init_cb()
}

pub fn (mut app App) main_loop() {
	for {
		if raylib.window_should_close() {
			break
		}

		app.update_cb()
		app.render_cb()
	}
}

pub fn (mut app App) deinitialize() {
	raylib.close_window()
	app.deinit_cb()
}
