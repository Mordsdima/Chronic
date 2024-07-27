module main

import os
import log
import toml
import superernd.cn
import encoding.base64

fn new_incoming(receiver voidptr, nl voidptr, client &cn.SClient) {
	//mut c := *client
	//mut s := *c.server
	log.info('New incoming connection from ${client.addr.str()}')
}

fn update_thread(srv &cn.Server) ! {
	for {
	}
}

fn main() {
	log.info('Initializating server....')

	mut conf_file := 'config.toml'

	if 'CONFIG' in os.environ() {
		conf_file = os.environ()['CONFIG']
	}

	log.info("Trying to load config from '${conf_file}'..")

	mut conf := toml.parse_file(conf_file) or {
		log.error('Failed to read config!')
		panic(err)
	}

	key := base64.decode(conf.value('auth.private_token_key').string())

	mut srv := cn.Server{
		key: key
		protocol_id: 0xdeadbeef
	}

	// ПОДНЯТЬ СЕРВЕР НА НОГИ ЕСЛИ НЕ ПИДОР
	log.info('Server is now working at ${conf.value('server.listen').string()}')
	srv.init(conf.value('server.listen').string())!

	// register events
	srv.eb.subscriber.subscribe("connect", new_incoming)

	spawn update_thread(&srv)

	for {
		srv.update()!
	}
}
