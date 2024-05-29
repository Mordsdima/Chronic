module engine

// this is App, (and Engine), App is just interface, while Engine manages renderers and many other shit

pub interface App {
	preinit() ! // Its different from init, for example you cant load textures from there (because renderers arent initializated), etc.
	init() !
	deinit() !
	update(i32, mut Context) !
	draw(i32, mut Context) !
}

pub struct Engine {
pub:
	app App
}

pub fn Engine.init_from_app(app App) !Engine {
	mut e := Engine{
		app: app
	}

	// Well, call preinit, actual context initialization is done by Engine.init

	e.app.preinit() or { return err }

	return e
}

pub fn (mut e Engine) init() ! {
	// Initialize the renderer, audiosystem, etc.

	
}