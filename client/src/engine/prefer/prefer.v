module prefer

import engine.renderers

// What i should prefer (try first, second..)

pub fn prefer_renderer() ![]renderers.Renderer {
	// Try get platform

	mut platform := ""

	$if n3ds ? {
		platform = "3ds"
	} $else $if windows {
		platform = "win"
	} $else $if macos {
		platform = "macos"
	} $else $if linux {
		platform = "linux" // our favourite linux :3
	} $else {
		platform = "unk"
		return error("Running on unsupported platform!")
	}

	// Got platform! Now returning prefered order

	return []
}