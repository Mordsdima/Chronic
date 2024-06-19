module main

import veb

@[get; "/users/:id"]
pub fn (mut app App) user_by_id(mut ctx Context, id int) veb.Result {
	// to ensure what he is authorizated, otherwise discard (user info only for authorizated)
	app.auth_user(mut ctx) or {
		ctx.res.set_status(.unauthorized)
		return ctx.json({
			"error": "Token not provided/invalid"
		})
	}

	user := app.find_user_by_id(id) or {
		ctx.res.set_status(.not_found)
		return ctx.json({
			"error": "User not found."
		})
	}

	return ctx.json({
		"name": user.name,
		"bio": user.bio,
		"avatar": user.avatar,
		"banner": user.banner,
		"country": user.country
	})
}

@[get; "/user"]
pub fn (mut app App) user_by_name(mut ctx Context) veb.Result {
	// to ensure what he is authorizated, otherwise discard (user info only for authorizated)
	app.auth_user(mut ctx) or {
		ctx.res.set_status(.unauthorized)
		return ctx.json({
			"error": "Token not provided/invalid"
		})
	}

	user := app.find_user_by_name(ctx.query['name'] or { "" }) or {
		ctx.res.set_status(.not_found)
		return ctx.json({
			"error": "User not found."
		})
	}

	return ctx.json({
		"name": user.name,
		"bio": user.bio,
		"avatar": user.avatar,
		"banner": user.banner,
		"country": user.country
	})
}