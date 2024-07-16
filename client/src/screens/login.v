module screens

import engine
import engine.types
import time

pub struct LoginScreen {
mut:
	ui      engine.UI
	endtime time.Time
	app     types.App = types.empty_app
}

pub fn (mut ls LoginScreen) init(mut ctx types.Context, mut app types.App) ! {
	ls.ui = engine.UI{}
	ls.ui.init(mut ctx.r)!
	ls.app = app
	ls.endtime = time.now().add(time.second * 5)
}

pub fn (mut ls LoginScreen) deinit() ! {}

pub fn (mut ls LoginScreen) update(delta f32, mut ctx types.Context) ! {
	if time.now() >= ls.endtime {
		ctx.set_screen(mut MenuScreen{}, mut ls.app)!
	}
}

pub fn (mut ls LoginScreen) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	ls.ui.begin()

	ls.ui.label(types.Rect{ x: 0.4, y: 0.43, w: 0.2, h: 0.07 }, "Login is not realizated. You'll return to menu in 5 seconds...", mut
		types.Color{})!

	ls.ui.end()

	ctx.r.end()
}
