module types

pub interface Screen {
mut:
	init(mut Context, mut App) !
	deinit() !
	update(f32, mut Context) !
	draw(f32, mut Context) !
}

pub struct EmptyScreen {}

pub fn (mut es EmptyScreen) init(mut ctx Context, mut app App) ! {}

pub fn (mut es EmptyScreen) deinit() ! {}

pub fn (mut es EmptyScreen) update(delta f32, mut ctx Context) ! {}

pub fn (mut es EmptyScreen) draw(delta f32, mut ctx Context) ! {}
