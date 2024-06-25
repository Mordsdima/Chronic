module main

import engine
import engine.types

// This is literally rewrite of old main.v

pub struct Chronical {
mut:
	player_img int
	ui engine.UI
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
	ctx.r.set_bg_color(mut types.Color{ r: 170, g: 170, b: 170 })

	c.player_img = ctx.r.load_image("assets/player.png")!
	c.ui = engine.UI{}
	c.ui.init(mut ctx.r)!
}

pub fn (mut c Chronical) deinit() ! {
}

pub fn (mut c Chronical) update(delta f32, mut ctx types.Context) ! {
	//c.mui.update()
}

pub fn (mut c Chronical) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	ctx.r.draw_image(c.player_img, 0, 0)!

	/*c.mui.begin()

	if c.mui.begin_window("hello world", types.Rect{
		x: 350, y: 40, w: 300, h: 200
	}) {
		c.mui.end_window()
	}

	c.mui.end()

	c.mui.draw()!*/

	c.ui.begin()

	c.ui.label(types.Rect{ x: 0.4, y: 0.45, w: 0.2, h: 0.05 }, "Hello world!", mut types.Color{})!

	c.ui.end()

	ctx.r.end()


}
