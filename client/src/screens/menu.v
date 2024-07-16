module screens

import engine
import engine.types

pub struct MenuScreen {
mut:
	ui    engine.UI
	app   types.App = types.empty_app
	block bool
}

pub fn (mut ms MenuScreen) init(mut ctx types.Context, mut app types.App) ! {
	ms.ui = engine.UI{}
	ms.ui.init(mut ctx.r)!
	ms.app = app
}

pub fn (mut ms MenuScreen) deinit() ! {}

pub fn (mut ms MenuScreen) update(delta f32, mut ctx types.Context) ! {}

pub fn (mut ms MenuScreen) draw(delta f32, mut ctx types.Context) ! {
	if ms.block {
		return
	}
	ctx.r.begin()

	ms.ui.begin()

	ms.ui.label(types.Rect{ x: 0.4, y: 0.4, w: 0.2, h: 0.05 }, 'Welcome to alpha-version of Chronical!', mut
		types.Color{})!

	if ms.ui.button(types.Rect{ x: 0.4, y: 0.45, w: 0.2, h: 0.05 }, 'join server', mut
		types.Color{
		a: 255
	})!
	{
		ctx.set_screen(mut ServerConnectScreen{}, mut ms.app)!
		// Block further render!
		ms.block = true
	}

	if ms.ui.button(types.Rect{ x: 0.4, y: 0.51, w: 0.2, h: 0.05 }, 'login into the account', mut
		types.Color{
		a: 255
	})!
	{
		ctx.set_screen(mut LoginScreen{}, mut ms.app)!
		// Block further render!
		ms.block = true
	}

	ms.ui.end()

	ctx.r.end()
}
