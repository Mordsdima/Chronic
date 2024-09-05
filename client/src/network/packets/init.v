module packets

import network.types

pub struct InitPacket {
pub mut:
	version string = $d('ver', 'git-commit-?')
}

@[pid: 0x00]
pub struct InitPacketCreator {}

pub fn (_ InitPacketCreator) create() types.Packet {
	return InitPacket{}
}

pub fn (ip InitPacket) write(mut w types.Writer) ! {
	w.write_string(ip.version)
}

pub fn (mut ip InitPacket) read(mut r types.Reader) ! {
	ip.version = r.read_string()
}

pub fn (mut ip InitPacket) process() ! {}

pub fn (mut ip InitPacket) clear() {
	ip.version = $d('ver', 'git-commit-?')
}
