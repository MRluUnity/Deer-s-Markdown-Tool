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

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 内容UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 头部UI：帮助菜单按钮：文字编辑器：id_pressed信号
func _on_text_edit_lines_edited_from(from_line: int, to_line: int) -> void:
	var edit_text : PackedStringArray = text_edit.text.split("\n")
	for i in context_text.get_children():
		i.queue_free()

	for i in edit_text:
		var texture_label : RichTextLabel = RichTextLabel.new()
		var text : String = i
		if i.begins_with("##### "):
			texture_label.add_theme_font_size_override("normal_font_size", 24)
			text = i.erase(0, 6)
		elif i.begins_with("#### "):
			texture_label.add_theme_font_size_override("normal_font_size", 36)
			text = i.erase(0, 5)
		elif i.begins_with("### "):
			texture_label.add_theme_font_size_override("normal_font_size", 48)
			text = i.erase(0, 4)
		elif i.begins_with("## "):
			texture_label.add_theme_font_size_override("normal_font_size", 60)
			text = i.erase(0, 3)
		elif i.begins_with("# "):
			texture_label.add_theme_font_size_override("normal_font_size", 72)
			text = i.erase(0, 2)
		context_text.add_child(texture_label)
		texture_label.fit_content = true
		texture_label.text = text
#endregion

# TODO 内容UI ===============>工具方法<===============
#region 工具方法

#endregion
