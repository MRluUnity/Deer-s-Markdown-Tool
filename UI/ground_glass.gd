#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends CanvasLayer

# TODO 毛玻璃遮罩 ===============>信 号<===============
#region 信号

#endregion

# TODO 毛玻璃遮罩 ===============>常 量<===============
#region 常量

#endregion

# TODO 毛玻璃遮罩 ===============>变 量<===============
#region 变量
@onready var panel: Panel = $Panel
var lod : float = 0
#endregion

# TODO 毛玻璃遮罩 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	panel.material.set_shader_parameter("lod", lod)

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 毛玻璃遮罩 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 毛玻璃遮罩 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 毛玻璃遮罩：进入模糊方法
func glass_enter() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "lod", 3, .75)

# TODO_FUC 毛玻璃遮罩：退出模糊方法
func glass_exit() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "lod", 0, .75)
#endregion
