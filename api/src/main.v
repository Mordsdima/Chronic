module main

import os
import orm
import log
import toml
import veb
import saving
import veb.auth
import db.sqlite
import db.tables

pub struct Context {
	veb.Context
}

pub struct App {
	veb.Middleware[Context]
pub mut:
	saver saving.Saver
	db   orm.Connection
	auth auth.Auth[orm.Connection]
	game_servers []string // a list lol
	private_token_key string
}

fn main() {
	log.info("Hello!")
	
	mut conf_file := "config.toml"

	if "CONFIG" in os.environ() {
		conf_file = os.environ()["CONFIG"]
	}

	log.info("Trying to loading config from '${conf_file}'..")

	mut conf := toml.parse_file(conf_file) or { log.error("Failed to read config!"); panic(err) } // купил письки? фатальная ошибка

	mut saver := saving.Saver(unsafe { nil })

	if conf.value("saver.backend").string() == "local" {
		saver = saving.LocalSaver{}
	} else {
		log.fatal("No valid save backend provided. Fix it in config.toml")
	}

	mut app := App{
		db: sqlite.connect(conf.value("db.host").string()) or { panic(err) },
		saver: saver
	}

	for s in conf.value("game.servers").array() {
		app.game_servers << s.string()
	}
	app.private_token_key = conf.value("game.private_token_key").string()

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
