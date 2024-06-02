module types

import math.vec

// We have a "gg.m4" but its not "cross-platform" (depends on gg), at least we cant "convert" gg.m4 matrix to raylib one for example
// part of code from original "gg.m4"
// the license of "gg.m4" is MIT

pub struct Matrix {
pub mut:
	e [16]f32
}

// Sum of matrix, operator +
pub fn (a Matrix) + (b Matrix) Matrix {
	unsafe {
		// vfmt off
		return Matrix{ e: [
			a.e[0 ] + b.e[0 ],  a.e[1 ] + b.e[1 ],  a.e[2 ] + b.e[2 ],  a.e[3 ] + b.e[3 ],
			a.e[4 ] + b.e[4 ],  a.e[5 ] + b.e[5 ],  a.e[6 ] + b.e[6 ],  a.e[7 ] + b.e[7 ],
			a.e[8 ] + b.e[8 ],  a.e[9 ] + b.e[9 ],  a.e[10] + b.e[10],  a.e[11] + b.e[11],
			a.e[12] + b.e[12],  a.e[13] + b.e[13],  a.e[14] + b.e[14],  a.e[15] + b.e[15],
		]!}
		// vfmt on
	}
}

// Subtraction of matrix, operator -
pub fn (a Matrix) - (b Matrix) Matrix {
	unsafe {
		// vfmt off
		return Matrix{ e: [
			a.e[0 ] - b.e[0 ],  a.e[1 ] - b.e[1 ],  a.e[2 ] - b.e[2 ],  a.e[3 ] - b.e[3 ],
			a.e[4 ] - b.e[4 ],  a.e[5 ] - b.e[5 ],  a.e[6 ] - b.e[6 ],  a.e[7 ] - b.e[7 ],
			a.e[8 ] - b.e[8 ],  a.e[9 ] - b.e[9 ],  a.e[10] - b.e[10],  a.e[11] - b.e[11],
			a.e[12] - b.e[12],  a.e[13] - b.e[13],  a.e[14] - b.e[14],  a.e[15] - b.e[15],
		]!}
		// vfmt on
	}
}

pub fn (a Matrix) * (b Matrix) Matrix {
	unsafe {
		// vfmt off
		return Matrix{ e: [
			a.e[0] * b.e[0] + a.e[1] * b.e[4] + a.e[2] * b.e[8] + a.e[3] * b.e[12], // [0][0]
			a.e[0] * b.e[1] + a.e[1] * b.e[5] + a.e[2] * b.e[9] + a.e[3] * b.e[13], // [0][1]
			a.e[0] * b.e[2] + a.e[1] * b.e[6] + a.e[2] * b.e[10] + a.e[3] * b.e[14], // [0][2]
			a.e[0] * b.e[3] + a.e[1] * b.e[7] + a.e[2] * b.e[11] + a.e[3] * b.e[15], // [0][3]

			a.e[4] * b.e[0] + a.e[5] * b.e[4] + a.e[6] * b.e[8] + a.e[7] * b.e[12], // [1][0]
			a.e[4] * b.e[1] + a.e[5] * b.e[5] + a.e[6] * b.e[9] + a.e[7] * b.e[13], // [1][1]
			a.e[4] * b.e[2] + a.e[5] * b.e[6] + a.e[6] * b.e[10] + a.e[7] * b.e[14], // [1][2]
			a.e[4] * b.e[3] + a.e[5] * b.e[7] + a.e[6] * b.e[11] + a.e[7] * b.e[15], // [1][3]

			a.e[8] * b.e[0] + a.e[9] * b.e[4] + a.e[10] * b.e[8] + a.e[11] * b.e[12], // [2][0]
			a.e[8] * b.e[1] + a.e[9] * b.e[5] + a.e[10] * b.e[9] + a.e[11] * b.e[13], // [2][1]
			a.e[8] * b.e[2] + a.e[9] * b.e[6] + a.e[10] * b.e[10] + a.e[11] * b.e[14], // [2][2]
			a.e[8] * b.e[3] + a.e[9] * b.e[7] + a.e[10] * b.e[11] + a.e[11] * b.e[15], // [2][3]

			a.e[12] * b.e[0] + a.e[13] * b.e[4] + a.e[14] * b.e[8] + a.e[15] * b.e[12], // [3][0]
			a.e[12] * b.e[1] + a.e[13] * b.e[5] + a.e[14] * b.e[9] + a.e[15] * b.e[13], // [3][1]
			a.e[12] * b.e[2] + a.e[13] * b.e[6] + a.e[14] * b.e[10] + a.e[15] * b.e[14], // [3][2]
			a.e[12] * b.e[3] + a.e[13] * b.e[7] + a.e[14] * b.e[11] + a.e[15] * b.e[15], // [3][3]
		]!}
		// vfmt on
	}
}

pub fn Matrix.add(a Matrix, b Matrix) Matrix {
	unsafe {
		return a + b
	}
}

pub fn Matrix.sub(a Matrix, b Matrix) Matrix {
	unsafe {
		return a - b
	}
}

pub fn Matrix.mul(a Matrix, b Matrix) Matrix {
	unsafe {
		return a * b
	}
}

pub fn Matrix.translate(xyz vec.Vec3[f32]) Matrix {
	return Matrix{
		// vfmt off
		e: [
			f32(1.0), 0.0, 0.0, xyz.x,
			f32(0.0), 1.0, 0.0, xyz.y,
			f32(0.0), 0.0, 1.0, xyz.z,
			f32(0.0), 0.0, 0.0, 1.0
		]!
		// vfmt on
	}
}
