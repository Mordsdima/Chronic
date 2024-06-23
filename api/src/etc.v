module main

import os
import veb

fn get_commit() ?string {
	res := os.execute('git rev-parse HEAD')
	if res.exit_code != 0 {
		return none
	}
	return res.output[..40]
}

@[get]
pub fn (mut app App) version(mut ctx Context) veb.Result {
	commit := (get_commit() or { 'UNKNOWN_COMMIT' })
	return ctx.json({
		'version': '0.0.0-DEV+${commit}'
		'os':      os.user_os()
	})
}

pub fn (mut ctx Context) not_found() veb.Result {
	// 404
	ctx.res.set_status(.not_found)
	return ctx.json({
		'error': '404 bro'
	})
}
