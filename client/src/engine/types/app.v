module types

pub interface App {
mut:
	preinit() !
	init(mut Context) !
	deinit() !
	update(f32, mut Context) !
	draw(f32, mut Context) !
}

pub struct EmptyApp {
}

pub fn (mut app EmptyApp) preinit() ! {}

pub fn (mut app EmptyApp) init(mut context Context) ! {}

pub fn (mut app EmptyApp) deinit() ! {}

pub fn (mut app EmptyApp) update(delta f32, mut context Context) ! {}

pub fn (mut app EmptyApp) draw(delta f32, mut context Context) ! {}

pub const empty_app = EmptyApp{}
