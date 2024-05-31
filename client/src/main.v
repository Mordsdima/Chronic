module main

import engine
import engine.types
import time

// This is literally rewrite of old main.v

pub struct Chronical {
}

fn main() {
	mut app := types.App(Chronical{})

	mut eng := engine.Engine.init_from_app(app)!

	eng.init(
		title: "Chronical; Built by V: ${@VHASH} (hash)"
	) or { panic(err) }

	eng.run() or { panic(err) }

	eng.end() or { panic(err) }
}

pub fn (c Chronical) preinit() ! {
}

pub fn (c Chronical) init(mut ctx types.Context) ! {
	ctx.r.set_bg_color(mut types.Color{r: 255, g: 255, b: 255})
}

pub fn (c Chronical) deinit() ! {
}

pub fn (c Chronical) update(delta f32, mut ctx types.Context) ! {
}

pub fn (c Chronical) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	ctx.r.end()
}
