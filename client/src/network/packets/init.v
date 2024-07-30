module packets

import network.types

pub struct InitPacket {
pub mut:
	version = $d('ver', 'git-commit-?')
}

pub fn (mut ip InitPacket) write(mut w types.Writer) {
	w.write_string(ip.version)
}

pub fn (mut ip InitPacket) read(mut r types.Reader) {
	ip.version = r.read_string()
}

pub fn (mut ip InitPacket) clear() {
	ip.version = $d('ver', 'git-commit-?')
}

pub fn (mut ip InitPacket) clone() InitPacket {
	return InitPacket{
		version: ip.version
	}
}