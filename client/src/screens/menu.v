module screens

import engine
import engine.types

pub struct MenuScreen {
mut:
	ui engine.UI
}

pub fn (mut ms MenuScreen) init(mut ctx types.Context, mut app types.App) ! {
	ms.ui = engine.UI{}
	ms.ui.init(mut ctx.r)!
}

pub fn (mut ms MenuScreen) deinit() ! {}
pub fn (mut ms MenuScreen) update(delta f32, mut ctx types.Context) ! {}
pub fn (mut ms MenuScreen) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	ms.ui.begin()

	ms.ui.label(types.Rect{ x: 0.4, y: 0.45, w: 0.2, h: 0.05 }, "Hello world!", mut types.Color{})!

	ms.ui.end()

	ctx.r.end()
}