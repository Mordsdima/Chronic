module types

pub interface App {
	preinit() ! // Its different from init, for example you cant load textures from there (because renderers arent initializated), etc.
	init(mut Context) !
	deinit() !
	update(f32, mut Context) !
	draw(f32, mut Context) !
}
