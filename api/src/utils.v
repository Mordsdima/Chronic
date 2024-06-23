module main

import db.tables
import superernd.jwt

pub struct IpApiResponse {
pub:
	country string = 'XX' @[json: 'countryCode']
}

pub struct AccountModificationRequest {
pub:
	key   string
	value string
}

pub fn (mut app App) find_user_by_name(name string) ?tables.User {
	user := sql app.db {
		select from tables.User where name == name limit 1
	} or { return none }

	return user[0]
}

pub fn (mut app App) find_user_by_id(id int) ?tables.User {
	user := sql app.db {
		select from tables.User where id == id limit 1
	} or { return none }

	return user[0]
}

pub fn (mut app App) auth_user(mut ctx Context) !tables.User {
	alg := jwt.new_algorithm(jwt.AlgorithmType.hs256)
	claims_decoded := jwt.verify[UserClaims](ctx.get_header(.authorization)!, alg, app.salt) or {
		return err
	}
	// token := app.auth.find_token(ctx.get_header(.authorization)!) or { return error("Token not found.") }

	return app.find_user_by_id(claims_decoded.id) or { return error('User not found.') }
}
