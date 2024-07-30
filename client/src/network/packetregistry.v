module network

import network.types
import network.packets

// A registry of packets!

pub enum Packets {
	init = 0x00
}

pub struct PRegistry {
pub mut:
	registry map[Packets]types.Packet
}

pub fn (mut preg PRegistry) register(packet Packets, s types.Packet) {
	preg.registry[packet] = s
} 

pub fn (mut preg PRegistry) init() {
	// Registers all packets
	preg.register(Packets.init, packets.InitPacket{})
}

// TODO: Read packet