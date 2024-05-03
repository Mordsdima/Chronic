module main

import raylib
import log

@[heap]
pub struct State {
pub mut:
	camera       C.Camera2D
	textures     Textures
	player_pos_x i32
	player_pos_y i32
}

pub struct Textures {
pub mut:
	player C.Texture
}

type Userdata = State

fn main() {
	mut app_state := State{
		camera: C.Camera2D{
			offset: C.Vector2{
				x: 800 / 2
				y: 600 / 2
			}
			target: C.Vector2{
				x: 32
				y: 32
			}
			rotation: 0
			zoom: 1
		}
		textures: Textures{}
	}

	mut app := App{
		title: 'Chronical'
		userdata: &app_state
	}

	app.render_cb = app.render
	app.update_cb = app.update
	app.deinit_cb = app.deinit
	app.init_cb = app.init

	app.initialize()
	log.info('Loading textures..')
	app_state.textures.player = raylib.load_texture('./assets/player.png')
	log.info('Finished!')
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

	raylib.begin_mode_2d(app.userdata.camera)

	// rendering a player
	raylib.draw_texture(app.userdata.textures.player, app.userdata.player_pos_x, app.userdata.player_pos_y,
		C.Color{
		r: u8(0xff)
		g: u8(0xff)
		b: u8(0xff)
		a: u8(0xff)
	})

	raylib.end_mode_2d()

	raylib.end_drawing()
}

pub fn (mut app App) update() {
	if raylib.is_key_pressed(raylib.Keys.key_a) {
		println('a')
	}
}

pub fn (mut app App) deinit() {
}

pub fn (mut app App) init() {
}
