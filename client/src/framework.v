module main

import raylib
import log

type InitFunction = fn ()

type DeinitFunction = fn ()

type RenderFunction = fn ()

type UpdateFunction = fn ()

// const default_handler = fn() {}

@[heap]
pub struct App {
pub:
	width  int    = 1280
	height int    = 720
	title  string = '(empty)'
pub mut:
	userdata &Userdata = unsafe { nil }

	render_cb RenderFunction = fn () {}
	update_cb UpdateFunction = fn () {}
	init_cb   InitFunction   = fn () {}
	deinit_cb DeinitFunction = fn () {}
}

pub fn (mut app App) initialize() {
	// We here initializating the raylib and then, init_cb

	log.info('Initializating framework...')

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
	log.info('Deinitializated framework.')
}
