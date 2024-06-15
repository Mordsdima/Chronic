module main

import engine
import engine.types
import time

// This is literally rewrite of old main.v

pub struct Chronical {
mut:
	player_img int
	mui engine.MicroUI
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
}

pub fn (mut c Chronical) init(mut ctx types.Context) ! {
	ctx.r.set_bg_color(mut types.Color{ r: 255, g: 255, b: 255 })

	c.player_img = ctx.r.load_image("assets/player.png")!

	println(c.player_img)

	println("Now game is initialized!")
	c.mui = engine.MicroUI{}
	c.mui.init(mut ctx.r)!
}

pub fn (mut c Chronical) deinit() ! {
}

pub fn (mut c Chronical) update(delta f32, mut ctx types.Context) ! {
}

pub fn (mut c Chronical) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	ctx.r.draw_image(c.player_img, 0, 0)!

	c.mui.begin()

	c.mui.end()


	ctx.r.end()


}
