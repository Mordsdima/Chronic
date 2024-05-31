module engine

import engine.renderers
import engine.types

// What i should prefer (try first, second..)

pub fn prefer_renderer() ![]types.Renderer {
	// Try get platform

	mut platform := ''

	$if n3ds ? {
		platform = '3ds'
	} $else $if windows {
		platform = 'win'
	} $else $if macos {
		platform = 'macos'
	} $else $if linux {
		platform = 'linux' // our favourite linux :3
	} $else {
		platform = 'unk'
		return error('Running on unsupported platform!')
	}

	// Got platform! Now returning prefered order

	if platform == '3ds' {
		return [renderers.NullRenderer{}] // 3DS will be supported in one time, but not yet
	} else if platform == 'linux' {
		return [renderers.GGRenderer{}]
	} else if platform == 'win' {
		return [renderers.GGRenderer{}]
	}

	return [renderers.NullRenderer{}]
}
