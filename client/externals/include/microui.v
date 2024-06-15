@[translated]
module include


const ( // empty enum
	mu_clip_part = 1
	mu_clip_all = 1
)


const ( // empty enum
	mu_command_jump = 1
	mu_command_clip = 1
	mu_command_rect = 2
	mu_command_text = 3
	mu_command_icon = 4
	mu_command_max = 5
)


const ( // empty enum
	mu_color_text = 0
	mu_color_border = 1
	mu_color_windowbg = 2
	mu_color_titlebg = 3
	mu_color_titletext = 4
	mu_color_panelbg = 5
	mu_color_button = 6
	mu_color_buttonhover = 7
	mu_color_buttonfocus = 8
	mu_color_base = 9
	mu_color_basehover = 10
	mu_color_basefocus = 11
	mu_color_scrollbase = 12
	mu_color_scrollthumb = 13
	mu_color_max = 14
)


const ( // empty enum
	mu_icon_close = 1
	mu_icon_check = 1
	mu_icon_collapsed = 2
	mu_icon_expanded = 3
	mu_icon_max = 4
)


const ( // empty enum
	mu_res_active = 1 << 0
	mu_res_submit = 1 << 1
	mu_res_change = 1 << 2
)


const ( // empty enum
	mu_opt_aligncenter = 1 << 0
	mu_opt_alignright = 1 << 1
	mu_opt_nointeract = 1 << 2
	mu_opt_noframe = 1 << 3
	mu_opt_noresize = 1 << 4
	mu_opt_noscroll = 1 << 5
	mu_opt_noclose = 1 << 6
	mu_opt_notitle = 1 << 7
	mu_opt_holdfocus = 1 << 8
	mu_opt_autosize = 1 << 9
	mu_opt_popup = 1 << 10
	mu_opt_closed = 1 << 11
	mu_opt_expanded = 1 << 12
)


const ( // empty enum
	mu_mouse_left = 1 << 0
	mu_mouse_right = 1 << 1
	mu_mouse_middle = 1 << 2
)


const ( // empty enum
	mu_key_shift = 1 << 0
	mu_key_ctrl = 1 << 1
	mu_key_alt = 1 << 2
	mu_key_backspace = 1 << 3
	mu_key_return = 1 << 4
)

type Mu_Id = u32
type Mu_Real = f32
type Mu_Font = voidptr
struct Mu_Vec2 { 
	x int
	y int
}
struct Mu_Rect { 
	x int
	y int
	w int
	h int
}
struct Mu_Color { 
	r u8
	g u8
	b u8
	a u8
}
struct Mu_PoolItem { 
	id Mu_Id
	last_update int
}
struct Mu_BaseCommand { 
	type_ int
	size int
}
struct Mu_JumpCommand { 
	base Mu_BaseCommand
	dst voidptr
}
struct Mu_ClipCommand { 
	base Mu_BaseCommand
	rect Mu_Rect
}
struct Mu_RectCommand { 
	base Mu_BaseCommand
	rect Mu_Rect
	color Mu_Color
}
struct Mu_TextCommand { 
	base Mu_BaseCommand
	font Mu_Font
	pos Mu_Vec2
	color Mu_Color
	str [1]i8
}
struct Mu_IconCommand { 
	base Mu_BaseCommand
	rect Mu_Rect
	id int
	color Mu_Color
}
union Mu_Command { 
	type_ int
	base Mu_BaseCommand
	jump Mu_JumpCommand
	clip Mu_ClipCommand
	rect Mu_RectCommand
	text Mu_TextCommand
	icon Mu_IconCommand
}
struct Mu_Layout { 
	body Mu_Rect
	next Mu_Rect
	position Mu_Vec2
	size Mu_Vec2
	max Mu_Vec2
	widths [16]int
	items int
	item_index int
	next_row int
	next_type int
	indent int
}
struct Mu_Container { 
	head &Mu_Command
	tail &Mu_Command
	rect Mu_Rect
	body Mu_Rect
	content_size Mu_Vec2
	scroll Mu_Vec2
	zindex int
	c.open int
}
struct Mu_Style { 
	font Mu_Font
	size Mu_Vec2
	padding int
	spacing int
	indent int
	title_height int
	scrollbar_size int
	thumb_size int
	colors [14]Mu_Color
}
fn C.mu_vec2(x int, y int) Mu_Vec2

pub fn mu_vec2(x int, y int) Mu_Vec2 {
	return C.mu_vec2(x, y)
}

fn C.mu_rect(x int, y int, w int, h int) Mu_Rect

pub fn mu_rect(x int, y int, w int, h int) Mu_Rect {
	return C.mu_rect(x, y, w, h)
}

fn C.mu_color(r int, g int, b int, a int) Mu_Color

pub fn mu_color(r int, g int, b int, a int) Mu_Color {
	return C.mu_color(r, g, b, a)
}

fn C.mu_init(ctx &Mu_Context) 

pub fn mu_init(ctx &Mu_Context)  {
	C.mu_init(ctx)
}

fn C.mu_begin(ctx &Mu_Context) 

pub fn mu_begin(ctx &Mu_Context)  {
	C.mu_begin(ctx)
}

fn C.mu_end(ctx &Mu_Context) 

pub fn mu_end(ctx &Mu_Context)  {
	C.mu_end(ctx)
}

fn C.mu_set_focus(ctx &Mu_Context, id Mu_Id) 

pub fn mu_set_focus(ctx &Mu_Context, id Mu_Id)  {
	C.mu_set_focus(ctx, id)
}

fn C.mu_get_id(ctx &Mu_Context, data voidptr, size int) Mu_Id

pub fn mu_get_id(ctx &Mu_Context, data voidptr, size int) Mu_Id {
	return C.mu_get_id(ctx, data, size)
}

fn C.mu_push_id(ctx &Mu_Context, data voidptr, size int) 

pub fn mu_push_id(ctx &Mu_Context, data voidptr, size int)  {
	C.mu_push_id(ctx, data, size)
}

fn C.mu_pop_id(ctx &Mu_Context) 

pub fn mu_pop_id(ctx &Mu_Context)  {
	C.mu_pop_id(ctx)
}

fn C.mu_push_clip_rect(ctx &Mu_Context, rect Mu_Rect) 

pub fn mu_push_clip_rect(ctx &Mu_Context, rect Mu_Rect)  {
	C.mu_push_clip_rect(ctx, rect)
}

fn C.mu_pop_clip_rect(ctx &Mu_Context) 

pub fn mu_pop_clip_rect(ctx &Mu_Context)  {
	C.mu_pop_clip_rect(ctx)
}

fn C.mu_get_clip_rect(ctx &Mu_Context) Mu_Rect

pub fn mu_get_clip_rect(ctx &Mu_Context) Mu_Rect {
	return C.mu_get_clip_rect(ctx)
}

fn C.mu_check_clip(ctx &Mu_Context, r Mu_Rect) int

pub fn mu_check_clip(ctx &Mu_Context, r Mu_Rect) int {
	return C.mu_check_clip(ctx, r)
}

fn C.mu_get_current_container(ctx &Mu_Context) &Mu_Container

pub fn mu_get_current_container(ctx &Mu_Context) &Mu_Container {
	return C.mu_get_current_container(ctx)
}

fn C.mu_get_container(ctx &Mu_Context, name &i8) &Mu_Container

pub fn mu_get_container(ctx &Mu_Context, name &i8) &Mu_Container {
	return C.mu_get_container(ctx, name)
}

fn C.mu_bring_to_front(ctx &Mu_Context, cnt &Mu_Container) 

pub fn mu_bring_to_front(ctx &Mu_Context, cnt &Mu_Container)  {
	C.mu_bring_to_front(ctx, cnt)
}

fn C.mu_pool_init(ctx &Mu_Context, items &Mu_PoolItem, len int, id Mu_Id) int

pub fn mu_pool_init(ctx &Mu_Context, items &Mu_PoolItem, len int, id Mu_Id) int {
	return C.mu_pool_init(ctx, items, len, id)
}

fn C.mu_pool_get(ctx &Mu_Context, items &Mu_PoolItem, len int, id Mu_Id) int

pub fn mu_pool_get(ctx &Mu_Context, items &Mu_PoolItem, len int, id Mu_Id) int {
	return C.mu_pool_get(ctx, items, len, id)
}

fn C.mu_pool_update(ctx &Mu_Context, items &Mu_PoolItem, idx int) 

pub fn mu_pool_update(ctx &Mu_Context, items &Mu_PoolItem, idx int)  {
	C.mu_pool_update(ctx, items, idx)
}

fn C.mu_input_mousemove(ctx &Mu_Context, x int, y int) 

pub fn mu_input_mousemove(ctx &Mu_Context, x int, y int)  {
	C.mu_input_mousemove(ctx, x, y)
}

fn C.mu_input_mousedown(ctx &Mu_Context, x int, y int, btn int) 

pub fn mu_input_mousedown(ctx &Mu_Context, x int, y int, btn int)  {
	C.mu_input_mousedown(ctx, x, y, btn)
}

fn C.mu_input_mouseup(ctx &Mu_Context, x int, y int, btn int) 

pub fn mu_input_mouseup(ctx &Mu_Context, x int, y int, btn int)  {
	C.mu_input_mouseup(ctx, x, y, btn)
}

fn C.mu_input_scroll(ctx &Mu_Context, x int, y int) 

pub fn mu_input_scroll(ctx &Mu_Context, x int, y int)  {
	C.mu_input_scroll(ctx, x, y)
}

fn C.mu_input_keydown(ctx &Mu_Context, key int) 

pub fn mu_input_keydown(ctx &Mu_Context, key int)  {
	C.mu_input_keydown(ctx, key)
}

fn C.mu_input_keyup(ctx &Mu_Context, key int) 

pub fn mu_input_keyup(ctx &Mu_Context, key int)  {
	C.mu_input_keyup(ctx, key)
}

fn C.mu_input_text(ctx &Mu_Context, text &i8) 

pub fn mu_input_text(ctx &Mu_Context, text &i8)  {
	C.mu_input_text(ctx, text)
}

fn C.mu_push_command(ctx &Mu_Context, type_ int, size int) &Mu_Command

pub fn mu_push_command(ctx &Mu_Context, type_ int, size int) &Mu_Command {
	return C.mu_push_command(ctx, type_, size)
}

fn C.mu_next_command(ctx &Mu_Context, cmd &&Mu_Command) int

pub fn mu_next_command(ctx &Mu_Context, cmd &&Mu_Command) int {
	return C.mu_next_command(ctx, cmd)
}

fn C.mu_set_clip(ctx &Mu_Context, rect Mu_Rect) 

pub fn mu_set_clip(ctx &Mu_Context, rect Mu_Rect)  {
	C.mu_set_clip(ctx, rect)
}

fn C.mu_draw_rect(ctx &Mu_Context, rect Mu_Rect, color Mu_Color) 

pub fn mu_draw_rect(ctx &Mu_Context, rect Mu_Rect, color Mu_Color)  {
	C.mu_draw_rect(ctx, rect, color)
}

fn C.mu_draw_box(ctx &Mu_Context, rect Mu_Rect, color Mu_Color) 

pub fn mu_draw_box(ctx &Mu_Context, rect Mu_Rect, color Mu_Color)  {
	C.mu_draw_box(ctx, rect, color)
}

fn C.mu_draw_text(ctx &Mu_Context, font Mu_Font, str &i8, len int, pos Mu_Vec2, color Mu_Color) 

pub fn mu_draw_text(ctx &Mu_Context, font Mu_Font, str &i8, len int, pos Mu_Vec2, color Mu_Color)  {
	C.mu_draw_text(ctx, font, str, len, pos, color)
}

fn C.mu_draw_icon(ctx &Mu_Context, id int, rect Mu_Rect, color Mu_Color) 

pub fn mu_draw_icon(ctx &Mu_Context, id int, rect Mu_Rect, color Mu_Color)  {
	C.mu_draw_icon(ctx, id, rect, color)
}

fn C.mu_layout_row(ctx &Mu_Context, items int, widths &int, height int) 

pub fn mu_layout_row(ctx &Mu_Context, items int, widths &int, height int)  {
	C.mu_layout_row(ctx, items, widths, height)
}

fn C.mu_layout_width(ctx &Mu_Context, width int) 

pub fn mu_layout_width(ctx &Mu_Context, width int)  {
	C.mu_layout_width(ctx, width)
}

fn C.mu_layout_height(ctx &Mu_Context, height int) 

pub fn mu_layout_height(ctx &Mu_Context, height int)  {
	C.mu_layout_height(ctx, height)
}

fn C.mu_layout_begin_column(ctx &Mu_Context) 

pub fn mu_layout_begin_column(ctx &Mu_Context)  {
	C.mu_layout_begin_column(ctx)
}

fn C.mu_layout_end_column(ctx &Mu_Context) 

pub fn mu_layout_end_column(ctx &Mu_Context)  {
	C.mu_layout_end_column(ctx)
}

fn C.mu_layout_set_next(ctx &Mu_Context, r Mu_Rect, relative int) 

pub fn mu_layout_set_next(ctx &Mu_Context, r Mu_Rect, relative int)  {
	C.mu_layout_set_next(ctx, r, relative)
}

fn C.mu_layout_next(ctx &Mu_Context) Mu_Rect

pub fn mu_layout_next(ctx &Mu_Context) Mu_Rect {
	return C.mu_layout_next(ctx)
}

fn C.mu_draw_control_frame(ctx &Mu_Context, id Mu_Id, rect Mu_Rect, colorid int, opt int) 

pub fn mu_draw_control_frame(ctx &Mu_Context, id Mu_Id, rect Mu_Rect, colorid int, opt int)  {
	C.mu_draw_control_frame(ctx, id, rect, colorid, opt)
}

fn C.mu_draw_control_text(ctx &Mu_Context, str &i8, rect Mu_Rect, colorid int, opt int) 

pub fn mu_draw_control_text(ctx &Mu_Context, str &i8, rect Mu_Rect, colorid int, opt int)  {
	C.mu_draw_control_text(ctx, str, rect, colorid, opt)
}

fn C.mu_mouse_over(ctx &Mu_Context, rect Mu_Rect) int

pub fn mu_mouse_over(ctx &Mu_Context, rect Mu_Rect) int {
	return C.mu_mouse_over(ctx, rect)
}

fn C.mu_update_control(ctx &Mu_Context, id Mu_Id, rect Mu_Rect, opt int) 

pub fn mu_update_control(ctx &Mu_Context, id Mu_Id, rect Mu_Rect, opt int)  {
	C.mu_update_control(ctx, id, rect, opt)
}

fn C.mu_text(ctx &Mu_Context, text &i8) 

pub fn mu_text(ctx &Mu_Context, text &i8)  {
	C.mu_text(ctx, text)
}

fn C.mu_label(ctx &Mu_Context, text &i8) 

pub fn mu_label(ctx &Mu_Context, text &i8)  {
	C.mu_label(ctx, text)
}

fn C.mu_button_ex(ctx &Mu_Context, label &i8, icon int, opt int) int

pub fn mu_button_ex(ctx &Mu_Context, label &i8, icon int, opt int) int {
	return C.mu_button_ex(ctx, label, icon, opt)
}

fn C.mu_checkbox(ctx &Mu_Context, label &i8, state &int) int

pub fn mu_checkbox(ctx &Mu_Context, label &i8, state &int) int {
	return C.mu_checkbox(ctx, label, state)
}

fn C.mu_textbox_raw(ctx &Mu_Context, buf &i8, bufsz int, id Mu_Id, r Mu_Rect, opt int) int

pub fn mu_textbox_raw(ctx &Mu_Context, buf &i8, bufsz int, id Mu_Id, r Mu_Rect, opt int) int {
	return C.mu_textbox_raw(ctx, buf, bufsz, id, r, opt)
}

fn C.mu_textbox_ex(ctx &Mu_Context, buf &i8, bufsz int, opt int) int

pub fn mu_textbox_ex(ctx &Mu_Context, buf &i8, bufsz int, opt int) int {
	return C.mu_textbox_ex(ctx, buf, bufsz, opt)
}

fn C.mu_slider_ex(ctx &Mu_Context, value &Mu_Real, low Mu_Real, high Mu_Real, step Mu_Real, fmt &i8, opt int) int

pub fn mu_slider_ex(ctx &Mu_Context, value &Mu_Real, low Mu_Real, high Mu_Real, step Mu_Real, fmt &i8, opt int) int {
	return C.mu_slider_ex(ctx, value, low, high, step, fmt, opt)
}

fn C.mu_number_ex(ctx &Mu_Context, value &Mu_Real, step Mu_Real, fmt &i8, opt int) int

pub fn mu_number_ex(ctx &Mu_Context, value &Mu_Real, step Mu_Real, fmt &i8, opt int) int {
	return C.mu_number_ex(ctx, value, step, fmt, opt)
}

fn C.mu_header_ex(ctx &Mu_Context, label &i8, opt int) int

pub fn mu_header_ex(ctx &Mu_Context, label &i8, opt int) int {
	return C.mu_header_ex(ctx, label, opt)
}

fn C.mu_begin_treenode_ex(ctx &Mu_Context, label &i8, opt int) int

pub fn mu_begin_treenode_ex(ctx &Mu_Context, label &i8, opt int) int {
	return C.mu_begin_treenode_ex(ctx, label, opt)
}

fn C.mu_end_treenode(ctx &Mu_Context) 

pub fn mu_end_treenode(ctx &Mu_Context)  {
	C.mu_end_treenode(ctx)
}

fn C.mu_begin_window_ex(ctx &Mu_Context, title &i8, rect Mu_Rect, opt int) int

pub fn mu_begin_window_ex(ctx &Mu_Context, title &i8, rect Mu_Rect, opt int) int {
	return C.mu_begin_window_ex(ctx, title, rect, opt)
}

fn C.mu_end_window(ctx &Mu_Context) 

pub fn mu_end_window(ctx &Mu_Context)  {
	C.mu_end_window(ctx)
}

fn C.mu_open_popup(ctx &Mu_Context, name &i8) 

pub fn mu_open_popup(ctx &Mu_Context, name &i8)  {
	C.mu_open_popup(ctx, name)
}

fn C.mu_begin_popup(ctx &Mu_Context, name &i8) int

pub fn mu_begin_popup(ctx &Mu_Context, name &i8) int {
	return C.mu_begin_popup(ctx, name)
}

fn C.mu_end_popup(ctx &Mu_Context) 

pub fn mu_end_popup(ctx &Mu_Context)  {
	C.mu_end_popup(ctx)
}

fn C.mu_begin_panel_ex(ctx &Mu_Context, name &i8, opt int) 

pub fn mu_begin_panel_ex(ctx &Mu_Context, name &i8, opt int)  {
	C.mu_begin_panel_ex(ctx, name, opt)
}

fn C.mu_end_panel(ctx &Mu_Context) 

pub fn mu_end_panel(ctx &Mu_Context)  {
	C.mu_end_panel(ctx)
}

