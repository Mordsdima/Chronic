module types

import math.vec

pub struct Camera2D {
pub mut:
	offset   vec.Vec2[f32]
	target   vec.Vec2[f32]
	rotation f32
	zoom     f32
}
