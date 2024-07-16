module screens

import engine
import engine.types

pub struct ServerConnectScreen {
mut:
	ui engine.UI
}

pub fn (mut scs ServerConnectScreen) init(mut ctx types.Context, mut app types.App) ! {
	scs.ui = engine.UI{}
	scs.ui.init(mut ctx.r)!
}

pub fn (mut scs ServerConnectScreen) deinit() ! {}

pub fn (mut scs ServerConnectScreen) update(delta f32, mut ctx types.Context) ! {}

pub fn (mut scs ServerConnectScreen) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	scs.ui.begin()

	scs.ui.label(types.Rect{ x: 0.9, y: 0.95, w: 0.1, h: 0.05 }, '↻ connecting to server', mut
		types.Color{})!

	scs.ui.end()

	ctx.r.end()
}
