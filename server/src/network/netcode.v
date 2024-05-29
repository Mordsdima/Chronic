module network

import libsodium
import encoding.binary
import net

pub fn init() ! {
	assert libsodium.sodium_init() >= 0
}

fn encrypt_aead(message &u8, message_len u64, additional &u8, additional_length u64, nonce &u8, key &u8) ! {
	mut elen := u64(0)
	result := libsodium.crypto_aead_xchacha20poly1305_ietf_encrypt(message, &elen, message,
		message_len, additional, additional_length, unsafe { nil }, nonce, key)
	if result != 0 || elen != message_len + 32 {
		return error('An error has occured')
	}
}

fn generate_key(buf &u8, len usize) {
	libsodium.randombytes_buf(buf, len)
}

pub fn create_private_connect_token(cid u64, timeout u32, addresses []net.Addr, userdata []u8, c2s_key []u8, s2c_key []u8) ![]u8 {
	if addresses.len > 32 {
		return error('Too many server addresses')
	}

	mut ct := []u8{}

	ct << ([u8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
	binary.little_endian_put_u64_at(mut ct, cid, 0)
	binary.little_endian_put_u32_at(mut ct, timeout, 8)
	binary.little_endian_put_u32_at(mut ct, u32(addresses.len), 12)

	for i, addr in addresses {
		match unsafe { net.AddrFamily(addr.f) } {
			.ip {
				unsafe {
					ct << [u8(0x01)]

					for n, addr_part in addr.str().split(':')[0].split('.') {
						ct << u8(addr_part.int())
					}

					ct << [u8(0), u8(0)]
					binary.little_endian_put_u16_end(mut ct, u16(addr.str().split(':')[1].int()))

					// ct << addr.addr.Ip.port
				}
			}
			.ip6 {
				// unsafe {
				//	ct << addr.addr.Ip6.addr
				//	ct << addr.addr.Ip6.port
				//}
			}
			else {
				println('Invalid ip address! Token will be 100% invalid')
			}
		}
	}

	ct << c2s_key
	ct << s2c_key

	ct << userdata

	unsafe { ct.grow_len(1008 - ct.len) }

	return ct
}

pub fn encrypt_private_connect_token(private_token []u8, private_key []u8, pid u64, exp u64, crt u64, timeout u32, addresses []net.Addr, c2s_key []u8, s2c_key []u8) ![]u8 {
	mut nonce := []u8{len: 24}
	generate_key(nonce.data, 24)

	mut additional := []u8{}

	additional << 'NETCODE 1.02\0'.bytes()
	unsafe { additional.grow_len(16) }
	binary.little_endian_put_u64_at(mut additional, pid, 13)
	binary.little_endian_put_u64_at(mut additional, exp, 21)
	// binary.little_endian_put_u64_at(mut additional, crt, 29)

	// как я понял, nonce это то значение которое никогда больше не используется

	mut ct := []u8{}

	unsafe { ct.grow_len(24) }
	binary.little_endian_put_u64_at(mut ct, pid, 0)
	binary.little_endian_put_u64_at(mut ct, crt, 8)
	binary.little_endian_put_u64_at(mut ct, exp, 16)

	unsafe { ct.grow_len(24) }

	ct << nonce

	// encrypt_aead(&private_token, private_key.len, &additional, additional.len, &nonce, &private_key)

	ct << private_token

	unsafe { ct.grow_len(8) }

	binary.little_endian_put_u32_at(mut ct, timeout, 40)

	binary.little_endian_put_u32_at(mut ct, u32(addresses.len), 44)

	for i, addr in addresses {
		match unsafe { net.AddrFamily(addr.f) } {
			.ip {
				unsafe {
					ct << [u8(0x01)]

					for n, addr_part in addr.str().split(':')[0].split('.') {
						ct << u8(addr_part.int())
					}

					ct << [u8(0), u8(0)]
					binary.little_endian_put_u16_end(mut ct, u16(addr.str().split(':')[1].int()))

					// ct << addr.addr.Ip.port
				}
			}
			.ip6 {
				// unsafe {
				//	ct << addr.addr.Ip6.addr
				//	ct << addr.addr.Ip6.port
				//}
			}
			else {
				println('Invalid ip address! Token will be 100% invalid')
			}
		}
	}

	ct << c2s_key
	ct << s2c_key

	unsafe { ct.grow_len(2048 - ct.len) }

	return ct
}

pub fn create_token() {
}

pub fn create_server(private_key []u8) ! {
	if private_key.len != 32 {
		return error('Invalid private key length!')
	}
}
