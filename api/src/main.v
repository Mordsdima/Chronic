module main

import veb
import veb.auth
import db.sqlite
import db.tables

pub struct Context {
	veb.Context
}

pub struct App {
	veb.Middleware[Context]
pub mut:
	db   sqlite.DB
	auth auth.Auth[sqlite.DB]
}

fn main() {
	println("Hello!")
	mut app := App{
		db: sqlite.connect('main.db') or { panic(err) }
	}
	app.auth = auth.new(app.db)
	app.use(veb.cors[Context](veb.CorsOptions{
		origins: ['*']
		allowed_methods: [.get, .head, .patch, .put, .post, .delete]
	}))

	// Init database if not already (create table if not exists)
	sql app.db {
		create table tables.User
	}!

	veb.run[App, Context](mut app, 8080)
}
