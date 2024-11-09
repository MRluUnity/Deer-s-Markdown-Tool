# TODO UI工具类
extends Node

# TODO UI工具类 ===============>信 号<===============
#region 信号

#endregion

# TODO UI工具类 ===============>常 量<===============
#region 常量

#endregion

# TODO UI工具类 ===============>变 量<===============
#region 变量

#endregion

# TODO UI工具类 ===============>信号链接方法<===============
#region 信号链接方法
func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
#endregion

# TODO UI工具类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC UI工具类：UI进入
func ui_enter(tween_control : Control, current_pos : Vector2) -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(tween_control, "global_position:y", current_pos.y, .75)
	await tween.finished

# TODO_FUC UI工具类：UI退出
func ui_exit(tween_control : Control) -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(tween_control, "global_position:y", -1000, .75)
	await tween.finished

# TODO_FUC UI工具类：隐藏子UI
## 隐藏当前UI的所有子UI
func hide_all_ui(parent_ui : Node, not_hide_ui : Node) -> void:
	for i in parent_ui.get_children():
		if i == not_hide_ui: continue
		if i is Control:
			i._hide()

# TODO_FUC UI工具类：启用按钮
## 启用当前UI下的所有按钮
func enable_all_button(parent_ui : Node) -> void:
	for i in parent_ui.get_children():
		if i is Button:
			i.disabled = false

# TODO_FUC UI工具类：文字漂浮
func fly_text(pos : Vector2, text : String, time : float, font_size : int = 48, font_color : Color = Color.BLACK) -> void:
	var text_label : Label = Label.new()
	var text_font : LabelSettings = LabelSettings.new()
	var free_label : Callable = func():
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(text_label, "global_position:y", text_label.global_position.y - 100, .75)
		tween.parallel().tween_property(text_label, "modulate:a", 0, .75)
		await tween.finished
		text_label.queue_free()

	text_font.font_size = font_size
	text_font.font_color = font_color

	text_label.label_settings = text_font
	text_label.text = text
	text_label.global_position = pos - Vector2(text_label.size.x / 2, 0)
	text_label.z_index = 100

	add_child(text_label)


	get_tree().create_timer(time).timeout.connect(free_label)

#endregion
