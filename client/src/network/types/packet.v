module types

// Generic interface to packet (e.g. write/read/clear)

pub interface Packet {
	write(mut Writer) !
mut:
	read(mut Reader) !
	process() !
	clear()
}

pub interface PacketCreator {
	create() Packet
}

pub struct PacketRegistry {
pub mut:
	reg map[int]PacketCreator
}

pub fn (mut pr PacketRegistry) add_handler[T]() ! {
	$for e in T.attributes {
		if e.has_arg && e.name == 'pid' {
			pr.reg[e.arg.int()] = T{}
		}
	}
}

pub fn (mut pr PacketRegistry) get_packet_creator_pid(pid int) ?PacketCreator {
	for k,v in pr.reg {
		if k == pid {
			return v
		}
	}
	return none
}

pub fn (mut pr PacketRegistry) get_packet_creator(pckt Packets) ?PacketCreator {
	return pr.get_packet_creator_pid(int(pckt))
}

pub enum Packets {
	init = 0x00
}