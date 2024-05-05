module main

import raylib
import log

@[heap]
pub struct State {
pub mut:
	camera       C.Camera2D
	textures     Textures
	player_pos   C.Vector2 = C.Vector2{ x: 0, y: 0 }
}

pub struct Textures {
pub mut:
	player C.Texture
}

type Userdata = State // here defining the "userdata" type instead of void* like in c libs, framework it needs, (its also can be voidptr)

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
	raylib.draw_texture_v(app.userdata.textures.player, app.userdata.player_pos
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
	if raylib.is_key_down(raylib.Keys.key_a) {
		app.userdata.player_pos.x -= 0.01
	} else if raylib.is_key_down(raylib.Keys.key_d) {
		app.userdata.player_pos.x += 0.01
	} else if raylib.is_key_down(raylib.Keys.key_w) {
		app.userdata.player_pos.y -= 0.01
	} else if raylib.is_key_down(raylib.Keys.key_s) {
		app.userdata.player_pos.y += 0.01
	}
}

pub fn (mut app App) deinit() {
}

pub fn (mut app App) init() {
}
