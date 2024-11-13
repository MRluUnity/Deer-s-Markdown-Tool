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
# 内容面板
@onready var context_panel_container: ContextPanelContainer = %ContextPanelContainer
# 侧边栏面板
@onready var slider_panel_container: SliderPanelContainer = %SliderPanelContainer
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
			# WARNING 这里记得后面进行封装和优化
			var file_dialog : FileDialog = FileDialog.new()
			file_dialog.file_selected.connect(_on_file_dialog_file_selected)
			file_dialog.canceled.connect(file_dialog.queue_free)
			file_dialog.confirmed.connect(file_dialog.queue_free)
			file_dialog.min_size = Vector2(500, 500)
			file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			file_dialog.access = FileDialog.ACCESS_FILESYSTEM
			file_dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
			file_dialog.show()
			add_child(file_dialog)
		2:
			get_tree().quit()
		3:
			var file_dialog : FileDialog = FileDialog.new()
			file_dialog.dir_selected.connect(_on_file_dialog_dir_selected)
			file_dialog.canceled.connect(file_dialog.queue_free)
			file_dialog.confirmed.connect(file_dialog.queue_free)
			file_dialog.min_size = Vector2(500, 500)
			file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
			file_dialog.access = FileDialog.ACCESS_FILESYSTEM
			file_dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
			file_dialog.show()
			add_child(file_dialog)

# TODO_FUC 头部UI：帮助菜单按钮：弹出界面：id_pressed信号
func _on_help_menu_button_id_pressed(id : int) -> void:
	match id:
		0:
			print("基本操作说明")
		1:
			print("快捷键说明")

# TODO_FUC 文件对话框：文件选择信号
func _on_file_dialog_file_selected(path : String) -> void:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var file_text : String = file.get_as_text()
	context_panel_container.current_file_path = path
	context_panel_container.context_h_box_container.show()
	context_panel_container.text_edit.text = file_text
	context_panel_container.text_edit.text_changed.emit()

func _on_file_dialog_dir_selected(dir : String) -> void:
	var dir_access = DirAccess.open(dir)
	var dir_files : Array = dir_access.get_files()
	slider_panel_container.dir_files = dir_files
	slider_panel_container.current_dir = dir
	print(dir_files)
#endregion

# TODO 头部UI ===============>工具方法<===============
#region 工具方法

#endregion
