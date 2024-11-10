#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name HeaderPanelContainer extends PanelContainer

# TODO 头部UI ===============>信 号<===============
#region 信号

#endregion

# TODO 头部UI ===============>常 量<===============
#region 常量

#endregion

# TODO 头部UI ===============>变 量<===============
#region 变量
# 文件菜单按钮
@onready var file_menu_button: MenuButton = %FileMenuButton
# 帮助菜单按钮
@onready var help_menu_button: MenuButton = %HelpMenuButton
#endregion

# TODO 头部UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	file_menu_button.get_popup().id_pressed.connect(_on_file_menu_button_id_pressed)
	help_menu_button.get_popup().id_pressed.connect(_on_help_menu_button_id_pressed)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 头部UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 头部UI：文件菜单按钮：Pressed信号
func _on_file_menu_button_pressed() -> void:
	pass

# TODO_FUC 头部UI：帮助菜单按钮：Pressed信号
func _on_help_menu_button_pressed() -> void:
	pass

# TODO_FUC 头部UI：文件菜单按钮：about_to_popup信号
func _on_file_menu_button_about_to_popup() -> void:
	await get_tree().process_frame
	file_menu_button.get_popup().min_size = Vector2(250, 0)

# TODO_FUC 头部UI：帮助菜单按钮：about_to_popup信号
func _on_help_menu_button_about_to_popup() -> void:
	await get_tree().process_frame
	help_menu_button.get_popup().min_size = Vector2(250, 0)
	help_menu_button.get_popup().get_focused_item()

# TODO_FUC 头部UI：文件菜单按钮：弹出界面：id_pressed信号
func _on_file_menu_button_id_pressed(id : int) -> void:
	match id:
		0:
			print("新建")
		1:
			print("打开")
		2:
			get_tree().quit()

# TODO_FUC 头部UI：帮助菜单按钮：弹出界面：id_pressed信号
func _on_help_menu_button_id_pressed(id : int) -> void:
	match id:
		0:
			print("基本操作说明")
		1:
			print("快捷键说明")
#endregion

# TODO 头部UI ===============>工具方法<===============
#region 工具方法

#endregion
