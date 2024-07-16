module types

@[heap]
pub struct Context {
pub mut:
	r  Renderer
	cs Screen
}

pub fn (mut ctx Context) set_screen(mut cs Screen, mut app App) ! {
	ctx.cs.deinit()!
	ctx.cs = cs
	ctx.cs.init(mut ctx, mut app)!
}
