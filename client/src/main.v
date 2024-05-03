module main

import raylib

@[heap]
pub struct State {
pub mut:
	camera C.Camera2D
}

type Userdata = State

fn main() {
	mut app_state := State{
		camera: C.Camera2D{
			offset: C.Vector2{ x: 0, y: 0 },
			target: C.Vector2{ x: 0, y: 0 },
			rotation: 0,
			zoom: 1
		}
	}


	mut app := App{
		title: 'Chronical',
		userdata: &app_state
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

	raylib.begin_mode_2d(app.userdata.camera)
	raylib.end_mode_2d()

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
