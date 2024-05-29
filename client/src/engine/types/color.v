module types

import gx

pub struct Color {
pub mut:
	r u8
	g u8
	b u8
	a u8
}

pub fn (mut c Color) to_gx_color() gx.Color {
	return gx.Color{
		r: c.r
		g: c.g
		b: c.b
		a: c.a
	}
}
