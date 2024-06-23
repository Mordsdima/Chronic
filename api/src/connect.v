module main

import veb
import time
import encoding.base64
import superernd.cn

pub fn (mut app App) initiate_connect(mut ctx Context) veb.Result {
	// Endpoint to request connect token to connect to game server(s)

	user := app.auth_user(mut ctx) or {
		ctx.res.set_status(.unauthorized)
		return ctx.json({
			'error': 'Token not provided/invalid'
		})
	}

	return ctx.text(cn.generate_public_token(
		nonce: cn.generate_random(24)
		key: base64.decode(app.private_token_key)
		exp: time.now().unix_milli() + 30 * 1000 + 1000 * app.game_servers.len
		protocol_id: 0xdeaddeaddeaddead
		timeout: 1
		s2c_key: cn.generate_random(32)
		c2s_key: cn.generate_random(32)
		server_addresses: app.game_servers
		client_id: u64(user.id)
		user_data: ctx.get_header(.user_agent) or { return ctx.request_error('NO TOKEN') }
	) or { return ctx.request_error('NO TOKEN') })
}
