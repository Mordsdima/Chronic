module main

import log
import screens
import engine
import engine.types
import globals

// This is literally rewrite of old main.v

pub struct Chronical {
mut:
	player_img int
	ui         engine.UI
}

fn main() {
	mut app := types.App(Chronical{})

	mut eng := engine.Engine.init_from_app(app)!

	eng.init(
		title: 'Chronical; Built by V: ${@VHASH} (hash)'
	) or { panic(err) }

	eng.run() or { panic(err) }

	eng.end() or { panic(err) }
}

pub fn (mut c Chronical) preinit() ! {
	(*globals.gmanager).init() or { // actually we should try refresh token, but now thats not even at API realizated
		log.error(err.str())
		return
	}
}

pub fn (mut c Chronical) init(mut ctx types.Context) ! {
	ctx.r.set_bg_color(mut types.Color{ r: 170, g: 170, b: 170 })

	c.player_img = ctx.r.load_image('assets/player.png')!
	c.ui = engine.UI{}
	c.ui.init(mut ctx.r)!

	// set screen lol
	ctx.set_screen(mut screens.MenuScreen{}, mut c)!
}

pub fn (mut c Chronical) deinit() ! {
}

pub fn (mut c Chronical) update(delta f32, mut ctx types.Context) ! {
}

pub fn (mut c Chronical) draw(delta f32, mut ctx types.Context) ! {
}
