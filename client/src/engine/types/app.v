module types

pub interface App {
	preinit() ! Its different from init, for example you cant load textures from there (because renderers arent initializated), etc.
	init(mut Context) !
	deinit() !
	update(i32, mut Context) !
	draw(i32, mut Context) !
}
