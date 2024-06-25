module engine

import engine.types
import log

// this is App, (and Engine), App is just interface, while Engine manages renderers and many other shit

pub struct Engine {
pub mut:
	app     types.App
	cur_scr types.Screen = types.EmptyScreen{}
mut:
	ctx types.Context
}

pub fn Engine.init_from_app(app types.App) !Engine {
	mut e := Engine{
		app: app
		ctx: types.Context{
			r: unsafe { nil }
		}
	}

	// Well, call preinit, actual context initialization is done by Engine.init

	e.app.preinit() or { return err }

	return e
}

pub fn (mut e Engine) init(c types.RendererConfig) ! {
	// Initialize the renderer, audiosystem, etc.

	// Get preferred renderers

	mut preferred_renderers := prefer_renderer() or { return err }

	for mut renderer in preferred_renderers {
		renderer.init(mut e.ctx, c) or {
			println(err)
			println('Failed to initialize this renderer, trying next')
			continue
		}

		log.info('Initializated renderer!')

		e.ctx.r = renderer

		break
	}

	e.ctx.r.init_app(mut e.app)!
}

pub fn (mut e Engine) run() ! {
	e.ctx.r.mainloop(mut e.app, mut e.ctx)!
}

pub fn (mut e Engine) end() ! {
	// Deinitialize
	e.ctx.r.deinit()!
	e.app.deinit()!
}
