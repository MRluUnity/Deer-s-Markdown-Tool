#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name SliderPanelContainer extends PanelContainer

# TODO 侧边栏UI ===============>信 号<===============
#region 信号

#endregion

# TODO 侧边栏UI ===============>常 量<===============
#region 常量

#endregion

# TODO 侧边栏UI ===============>变 量<===============
#region 变量
@onready var slider_v_box_container: VBoxContainer = %SliderVBoxContainer
@onready var context_panel_container: ContextPanelContainer = %ContextPanelContainer

var current_dir : String = "":
	set(v):
		current_dir = v
		if current_dir != "":
			create_slider_item()

var dir_files : Array
#endregion

# TODO 侧边栏UI ===============>虚方法<===============
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

# TODO 侧边栏UI ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 侧边栏UI ===============>工具方法<===============
#region 工具方法
# TODO_FUC 侧边栏UI：创建侧边栏物品
func create_slider_item() -> void:
	for i in slider_v_box_container.get_children():
		i.queue_free()

	var label : Label = Label.new()
	label.text = current_dir.split("/")[-1]
	label.add_theme_font_size_override("font_size", 32)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	slider_v_box_container.add_child(label)

	for i in dir_files:
		var button : Button = Button.new()
		button.focus_mode = Control.FOCUS_NONE
		button.text = i
		# 按下的是第几个按钮
		button.pressed.connect(func():
			var file_name = slider_v_box_container.get_child(get_index() + 1).text
			if context_panel_container.current_file_path != (current_dir + "/" + file_name):
				context_panel_container.current_file_path = (current_dir + "/" + file_name)
				var file : FileAccess = FileAccess.open(context_panel_container.current_file_path, FileAccess.READ)
				var file_text : String = file.get_as_text()
				context_panel_container.context_h_split_container.show()
				context_panel_container.text_edit.text = file_text
				context_panel_container.text_edit.text_changed.emit()
			)
		slider_v_box_container.add_child(button)
#endregion
