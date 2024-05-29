module main

import engine
import engine.types

// This is literally rewrite of old main.v

pub struct Chronical {

}

fn main() {
	mut app := types.App(Chronical{})

	mut eng := engine.Engine.init_from_app(app)!

	eng.init() or { panic(err) }

	eng.run() or { panic(err) }

	println("Running game!")
}

pub fn (c Chronical) preinit() ! {

}

pub fn (c Chronical) init(mut ctx types.Context) ! {
	ctx.r.set_bg_color(mut types.Color{
		
	})
}

pub fn (c Chronical) deinit() ! {

}

pub fn (c Chronical) update(delta i32, mut ctx types.Context) ! {

}

pub fn (c Chronical) draw(delta i32, mut ctx types.Context) ! {
	ctx.r.begin()



	ctx.r.end()
}