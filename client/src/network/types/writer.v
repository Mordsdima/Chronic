module types

import encoding.binary

pub struct Writer {
pub mut:
	buffer []u8
}

pub fn (mut w Writer) write_u8(v u8) {
	w.buffer << v // easy
}

pub fn (mut w Writer) write_u16(v u16) {
	w.buffer << []u8{len:2}
	binary.little_endian_put_u16_end(mut w.buffer, v)
}

pub fn (mut w Writer) write_u32(v u32) {
	w.buffer << []u8{len:4}
	binary.little_endian_put_u32_end(mut w.buffer, v)
}

pub fn (mut w Writer) write_u64(v u64) {
	w.buffer << []u8{len:8}
	binary.little_endian_put_u64_end(mut w.buffer, v)
}

// Now how about string, bytearray?

pub fn (mut w Writer) write_string(str string) {
	w.write_u32(u32(str.len))
	w.buffer << str.bytes()
}

pub fn (mut w Writer) read_bytearray(buf []u8) {
	w.write_u32(u32(buf.len))
	w.buffer << buf
}

// TODO: f32/f64
