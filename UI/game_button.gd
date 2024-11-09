#--------------------------------------
# 这个类是专门用来自己使用的 Button UI 类
# 类中自定义了 Button 的轴心为中心
# 定义了 Button 在鼠标进入后的一些线性动画
#--------------------------------------
class_name GameButton extends Button

# TODO 游戏按钮 ===============>信 号<===============
#region 信号

#endregion

# TODO 游戏按钮 ===============>常 量<===============
#region 常量

#endregion

# TODO 游戏按钮 ===============>变 量<===============
#region 变量
# 图标
@export var texture : Texture2D
@export var close_scale : bool = false
# 这个UI加载完毕后的位置
var current_pos : Vector2
#endregion

# TODO 游戏按钮 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	# 游戏按钮：修改聚焦模式为无
	focus_mode = FocusMode.FOCUS_NONE

	# 游戏按钮：信号链接
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _ready() -> void:
	# 游戏按钮：设置轴心为中心
	pivot_offset = size / 2


func _exit_tree() -> void:
	# 游戏按钮：信号断开链接
	mouse_entered.disconnect(_on_mouse_entered)
	mouse_exited.disconnect(_on_mouse_exited)

func _make_custom_tooltip(for_text: String) -> Object:
	var tool_tip : TipToolPanelContainer = UiTool.TIP_TOOL_PANEL_CONTAINER.instantiate()
	tool_tip.set_tip_tool(text, for_text, texture)
	return tool_tip
#endregion

# TODO 游戏按钮 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 游戏按钮：鼠标进入 UI 信号
# 当鼠标进入 UI 时需要按钮进行放大并且向某个方向移动
func _on_mouse_entered() -> void:
	# 游戏按钮：将初始化完毕后的坐标进行保存
	if not current_pos:
		current_pos = position

	z_index = 100
	if close_scale: return
	if disabled: return
	var tween : Tween = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", current_pos + Vector2(0, -size.y / 6), .25)
	tween.tween_property(self, "scale", Vector2.ONE * 1.2, .25)

# TODO_FUC 游戏按钮：鼠标退出 UI 信号
# 当鼠标退出 UI 时需要按钮还原
func _on_mouse_exited() -> void:
	z_index = 0

	if close_scale: return
	var tween : Tween = create_tween().set_parallel().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", current_pos, .25)
	tween.tween_property(self, "scale", Vector2.ONE, .25)
#endregion

# TODO 游戏按钮 ===============>工具方法<===============
#region 工具方法

#endregion
