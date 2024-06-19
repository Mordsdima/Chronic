module main

import os
import veb

fn get_commit() ?string {
	res := os.execute("git rev-parse HEAD")
	if res.exit_code != 0 { return none }
	return res.output[..40]
}

@[get]
pub fn (mut app App) version(mut ctx Context) veb.Result {
	commit := (get_commit() or { "0" })
	return ctx.json({
		'version': '0.0.0-DEV+${commit}'
		'os':      os.user_os()
	})
}