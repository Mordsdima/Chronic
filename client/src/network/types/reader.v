module types

import encoding.binary

pub struct Reader {
mut:
	buffer []u8
}

pub fn (mut r Reader) read_u8() u8 {
	a := r.buffer[0]
	r.buffer.delete_many(0, 1) 
	return a
}

pub fn (mut r Reader) read_u16() u16 {
	a := binary.little_endian_u16(r.buffer)
	r.buffer.delete_many(0, 2) 
	return a
}

pub fn (mut r Reader) read_u32() u32 {
	a := binary.little_endian_u32(r.buffer)
	r.buffer.delete_many(0, 4) 
	return a
}

pub fn (mut r Reader) read_u64() u64 {
	a := binary.little_endian_u64(r.buffer)
	r.buffer.delete_many(0, 8) 
	return a
}

pub fn (mut r Reader) read_string() string {
	l := r.read_u32()
	s := unsafe { tos(r.buffer.data, l) }
	r.buffer.delete_many(0, l) 
	return s
}

pub fn (mut r Reader) read_bytearray() []u8 {
	l := r.read_u32()
	b := r.buffer[..l].clone()
	r.buffer.delete_many(0, l) 
	return b
}