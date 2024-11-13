#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ContextPanelContainer extends PanelContainer

# TODO 内容UI ===============>信 号<===============
#region 信号

#endregion

# TODO 内容UI ===============>常 量<===============
#region 常量

#endregion

# TODO 内容UI ===============>变 量<===============
#region 变量
@onready var text_edit: TextEdit = %TextEdit
@onready var context_text: VBoxContainer = %ContextText
@onready var context_h_box_container: HBoxContainer = %ContextHBoxContainer
var current_file_path : String
#endregion

# TODO 内容UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("save"):
			var file : FileAccess = FileAccess.open(current_file_path, FileAccess.WRITE)
			file.store_string(text_edit.text)
			file.close()

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 内容UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 头部UI：帮助菜单按钮：文字编辑器：id_pressed信号
func _on_text_edit_lines_edited_from(_from_line: int, _to_line: int) -> void:
	var edit_texts : PackedStringArray = text_edit.text.split("\n")
	var title_level : int = 0

	for i in context_text.get_children():
		i.queue_free()

	for edit_text in edit_texts:
		var chars : Array = edit_text.split("")

		# 分割线语法
		if chars.size() == 3 and chars[0] == "-" and chars[1] == "-" and chars[2] == "-":
			var line_rect : ColorRect = ColorRect.new()
			line_rect.custom_minimum_size.y = 4
			context_text.add_child(line_rect)

		# 文字语法
		else:
			var texture_label : RichTextLabel = create_rich_text_label()

			title_level = process_title(chars, texture_label)

			chars = process_b_and_i(chars)

			chars = process_list(chars)

			for c in chars:
				texture_label.text += c

			texture_label.text = texture_label.text.erase(0, title_level)
			context_text.add_child(texture_label)

func _on_close_file_button_pressed() -> void:
	var file : FileAccess = FileAccess.open(current_file_path, FileAccess.WRITE)
	file.store_string(text_edit.text)
	file.close()
	context_h_box_container.hide()
#endregion

# TODO 内容UI ===============>工具方法<===============
#region 工具方法
# TODO_FUC 内容UI：初始化RichTextLabel
func create_rich_text_label() -> RichTextLabel:
	var texture_label : RichTextLabel = RichTextLabel.new()
	texture_label.selection_enabled = true
	texture_label.fit_content = true
	texture_label.bbcode_enabled = true
	set_font_size(24, texture_label)
	return texture_label

# TODO_FUC 内容UI：设置字体大小
func set_font_size(font_size : int, texture_label : RichTextLabel) -> void:
	texture_label.add_theme_font_size_override("normal_font_size", font_size)
	texture_label.add_theme_font_size_override("bold_font_size", font_size)
	texture_label.add_theme_font_size_override("italics_font_size", font_size)
	texture_label.add_theme_font_size_override("bold_italics_font_size", font_size)

# TODO_FUC 内容UI：标题语法处理
func process_title(chars : Array, texture_label : RichTextLabel) -> int:
	match chars:
		["#", "#", "#", "#", "#", " ", ..]:
			set_font_size(32, texture_label)
			return 6
		["#", "#", "#", "#", " ",..]:
			set_font_size(40, texture_label)
			return 5
		["#", "#", "#", " ",..]:
			set_font_size(48, texture_label)
			return 4
		["#", "#", " ", ..]:
			set_font_size(56, texture_label)
			return 3
		["#", " ", ..]:
			set_font_size(64, texture_label)
			return 2
	return 0

# TODO_FUC 内容UI：粗体、斜体语法处理
func process_b_and_i(chars : Array) -> Array:
	if chars[chars.find("*")] == "*" and chars[chars.rfind("*")] == "*":
		# 判断是否满足加粗
		if chars.size() > chars.find("*") + 1 \
		and chars[chars.find("*") + 1] == "*" \
		and chars[chars.rfind("*") - 1] == "*" \
		and chars.rfind("*") != chars.find("*") + 1 \
		and chars.rfind("*") - 1 != chars.find("*"):
			chars.pop_at(chars.find("*"))
			chars[chars.find("*")] = "**"
			chars.pop_at(chars.rfind("*",) - 1)
			chars[chars.rfind("*")] = "**"

			# 加粗处理
			if chars.find("**") != -1:
				chars[chars.find("**")] = "[b]"
			if chars.rfind("**") != -1:
				chars[chars.rfind("**")] = "[/b]"

		# 斜体处理
		if chars.find("*") != chars.rfind("*"):
			chars[chars.find("*")] = "[i]"
			chars[chars.rfind("*")] = "[/i]"
	return chars

# TODO_FUC 内容UI：有序无序列表语法处理
func process_list(chars : Array) -> Array:
	match chars:
		# 有序列表
		[var frist, ".", " ", ..]:
			if frist.is_valid_int():
				chars.push_front("	")
		# 无序列表
		["-", " ", ..]:
			chars.pop_front()
			chars.push_front(" [b]·[/b] ")
			chars.push_front("	")
	return chars
#endregion
