module screens

import engine
import engine.types

pub const loading_state = create_loading_state()

fn create_loading_state() &LoadingState {
	mut ls := LoadingState{}
	return &ls
}

pub struct LoadingState {
pub mut:
	text string = "Something loading.."
}

pub fn (mut ls LoadingState) server_connect() {
	ls.text = '↻ connecting to server'
}

pub struct LoadingScreen {
mut:
	ui engine.UI
}

pub fn (mut scs LoadingScreen) init(mut ctx types.Context, mut app types.App) ! {
	scs.ui = engine.UI{}
	scs.ui.init(mut ctx.r)!
}

pub fn (mut scs LoadingScreen) deinit() ! {}

pub fn (mut scs LoadingScreen) update(delta f32, mut ctx types.Context) ! {}

pub fn (mut scs LoadingScreen) draw(delta f32, mut ctx types.Context) ! {
	ctx.r.begin()

	scs.ui.begin()

	scs.ui.label(types.Rect{ x: 0.9, y: 0.95, w: 0.1, h: 0.05 }, loading_state.text, mut
		types.Color{})!

	scs.ui.end()

	ctx.r.end()
}
