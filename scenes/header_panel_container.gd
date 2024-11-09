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

# TODO 头部UI ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 头部UI ===============>工具方法<===============
#region 工具方法

#endregion
