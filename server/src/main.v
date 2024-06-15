module main

import network
import superernd.cn

const private_key = []u8{len: 32} // temporary needs to be changed

fn main() {
	println('Initializating server....')
	network.init() or { panic(err) }
	mut time := 0
	mut delta := 1 / 60

	/*println("yea")
	println(
		network.encrypt_private_connect_token(
			network.create_private_connect_token(0, 0, [net.Addr{}], ) or { panic(err) },
			[]u8{},
			0, 0
		) or { panic(err) }
		
	)*/
}
