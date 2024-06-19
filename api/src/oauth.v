module main

import veb

@[get]
pub fn (app &App) authorize(mut ctx Context) veb.Result {
	return ctx.text('Not yet implemented!')
}
