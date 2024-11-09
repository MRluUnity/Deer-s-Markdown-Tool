## TODO 状态机
class_name StateMachine extends Node

# TODO 状态机 ===============>信 号<===============
#region 信号

#endregion

# TODO 状态机 ===============>常 量<===============
#region 常量

#endregion

# TODO 状态机 ===============>变 量<===============
#region 变量
## 初始化的状态
@export var init_state : State

## 状态字典
var states : Dictionary
## 当前状态
var current_state : State
#endregion

# TODO 状态机 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

# 初始化
func _ready() -> void:
	for state in get_children():
		if state is State:
			states[state.name.to_upper()] = state
			state.update_state.connect(_on_update_state)

	if init_state:
		init_state.enter()
		current_state = init_state

# 渲染更新
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

# 物理更新
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 状态机 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 状态机：更新状态信号方法
## 用于更新状态的方法，该方法与state的update_state信号连接
func _on_update_state(state_name : String) -> void:
	if current_state.name == state_name:
		return

	var new_state : State = states[state_name.to_upper() + "STATE"]

	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
#endregion

# TODO 状态机 ===============>工具方法<===============
#region 工具方法

#endregion
