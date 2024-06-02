module types

pub interface App {
mut:
	preinit() !
	init(mut Context) !
	deinit() !
	update(f32, mut Context) !
	draw(f32, mut Context) !
}
