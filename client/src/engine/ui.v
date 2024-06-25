module engine

import engine.types
import engine.renderers

// thats a ui lol

@[heap]
pub struct UI {
mut:
	renderer  	types.Renderer = renderers.NullRenderer{}
	isinited  	bool
	positions   []f32
pub mut:
	default_wid f32 = 0.30
	default_hei f32 = 0.10
	default_spa f32 = 0.05
}

pub fn (mut ui UI) init(mut renderer types.Renderer) ! {
	if ui.isinited { return error("UI is already initializated!") }
	
	ui.isinited = true
	ui.renderer = renderer
	ui.positions = []
}

pub fn (mut ui UI) begin() {
	ui.positions = []
}

pub fn (mut ui UI) end() {
	ui.positions = []
}

pub fn (mut ui UI) label(relRect types.Rect, text string, mut color types.Color) ! {
	wwid, whei := ui.renderer.get_res()
	x := relRect.x * wwid
	y := relRect.y * whei
	w := relRect.w * wwid
	h := relRect.h * whei

	ui.renderer.draw_rect(types.Rect{
		x: x,
		y: y, 
		w: w,
		h: h,
	}, mut color)

	tw := ui.renderer.get_text_width(text)
	th := ui.renderer.get_text_height()
	tx := x + (w - tw) / 2
	ty := y + (h - th) / 2
	ui.renderer.draw_text(int(tx), int(ty), text)!
}

pub fn (mut ui UI) update() {
}