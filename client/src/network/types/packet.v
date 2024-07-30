module types

// Generic interface to packet (e.g. write/read/clear/clone)

pub interface Packet {
	write(mut Writer) !
	read(mut Reader) !
	clear()
	clone() Packet
}