module screens

import config
import globals
import engine
import engine.types
import log

pub struct MenuScreen {
mut:
	ui    engine.UI
	app   types.App = types.empty_app
	block bool
}

pub fn (mut ms MenuScreen) init(mut ctx types.Context, mut app types.App) ! {
	ms.ui = engine.UI{}
	ms.ui.init(mut ctx.r)!
	ms.app = app
}

pub fn (mut ms MenuScreen) deinit() ! {}

pub fn (mut ms MenuScreen) update(delta f32, mut ctx types.Context) ! {}

pub fn (mut ms MenuScreen) generic_error_handler(mut ctx types.Context, error IError) {
	log.error(error.str())
	ctx.set_screen(mut MenuScreen{}, mut ms.app) or { 
		log.error(err.str())
	}
}

pub fn (mut ms MenuScreen) join(mut ctx types.Context) {
	log.info("Hello from join function! Trying to log in into the account")

	mut login_info := config.get_login_information()

	if login_info.auth_token == "" {
		log.error("no really valid token found.")
		ctx.set_screen(mut MenuScreen{}, mut ms.app) or { 
			log.error(err.str())
		}
		return 
	}

	(*globals.gapi).login_via_auth_token(login_info.auth_token) or { // actually we should try refresh token, but now thats not even at API realizated
		ms.generic_error_handler(mut ctx, err)
		return
	}

	token := (*globals.gapi).connect() or {
		ms.generic_error_handler(mut ctx, err)
		return
	}

	(*globals.gmanager).connect(token) or { // trash code
		ms.generic_error_handler(mut ctx, err)
		return
	}

	log.info("yay! connected to server over chronic-network")
}

pub fn (mut ms MenuScreen) draw(delta f32, mut ctx types.Context) ! {
	if ms.block {
		return
	}
	ctx.r.begin()

	ms.ui.begin()

	ms.ui.label(types.Rect{ x: 0.4, y: 0.4, w: 0.2, h: 0.05 }, 'Welcome to alpha-version of Chronical!', mut
		types.Color{})!

	if ms.ui.button(types.Rect{ x: 0.4, y: 0.45, w: 0.2, h: 0.05 }, 'join server', mut
		types.Color{
		a: 255
	})!
	{	
		//println(loading_state)
		(*loading_state).server_connect()
		// start a thread of login
		spawn ms.join(mut ctx)
		ctx.set_screen(mut LoadingScreen{}, mut ms.app)!
		// Block further render!
		ms.block = true
	}

	if ms.ui.button(types.Rect{ x: 0.4, y: 0.51, w: 0.2, h: 0.05 }, 'login into the account', mut
		types.Color{
		a: 255
	})!
	{
		ctx.set_screen(mut LoginScreen{}, mut ms.app)!
		// Block further render!
		ms.block = true
	}

	$if debug {
		if ms.ui.button(types.Rect{ x: 0.92, y: 0.965, w: 0.08, h: 0.035 }, 'enter debugger', mut
			types.Color{
				a: 255
		})!
		{
			$dbg
		}
	}
	


	ms.ui.end()

	ctx.r.end()
}
