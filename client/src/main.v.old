module main

import raylib
import log
import math
import engine

@[heap]
pub struct State {
pub mut:
	camera       C.Camera2D
	textures     Textures
	player_pos   C.Vector2 = C.Vector2{ x: 0, y: 0 }
	player_ang   f32       = 0.0
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
				x: 1280 / 2
				y: 720 / 2
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
	//pivot := C.Vector2{ x: f32(app.userdata.textures.player.width) * 0.5, y: f32(app.userdata.textures.player.height) * 0.5 }

	raylib.draw_texture_pro(app.userdata.textures.player, 
		C.Rectangle{ width: f32(app.userdata.textures.player.width) , height: f32(app.userdata.textures.player.height) }, 
		C.Rectangle{ x: app.userdata.player_pos.x, y: app.userdata.player_pos.y, width: f32(app.userdata.textures.player.width), height: f32(app.userdata.textures.player.height) }
		C.Vector2{ x: f32(app.userdata.textures.player.width) / 2, y: f32(app.userdata.textures.player.width) /2  }, app.userdata.player_ang,
		C.Color{
			r: u8(0xff)
			g: u8(0xff)
			b: u8(0xff)
			a: u8(0xff)
		}
	)

	raylib.end_mode_2d()

	raylib.end_drawing()
}

pub fn (mut app App) update() {

	//app.userdata.camera.target = C.Vector2 {
	//	x: app.userdata.player_pos.x + 32,
	//	y: app.userdata.player_pos.y + 32
	//}

	mouse_pos := raylib.get_mouse_position()
	direction := raylib.vector2_subtract(mouse_pos, C.Vector2{ x: app.width/2, y: app.height/2 })
	angle := f32(math.degrees(math.atan2(direction.y, direction.x))) + 6.5
	app.userdata.player_ang = angle 

	if raylib.is_key_down(raylib.Keys.key_w) {
		mut dir := raylib.vector2_normalize(C.Vector2{ x: f32(math.cos(math.radians(app.userdata.player_ang))), y: f32(math.sin(math.radians(app.userdata.player_ang))) })
		app.userdata.player_pos = raylib.vector2_add(app.userdata.player_pos, raylib.vector2_scale(dir, 0.1))
		//app.userdata.player_pos += dir
	} else if raylib.is_key_down(raylib.Keys.key_s) {
		mut dir := raylib.vector2_normalize(C.Vector2{ x: f32(math.cos(math.radians(app.userdata.player_ang))), y: f32(math.sin(math.radians(app.userdata.player_ang))) })
		app.userdata.player_pos = raylib.vector2_subtract(app.userdata.player_pos, raylib.vector2_scale(dir, 0.1))
	}

}

pub fn (mut app App) deinit() {
}

pub fn (mut app App) init() {
	raylib.set_target_fps(60)
}
