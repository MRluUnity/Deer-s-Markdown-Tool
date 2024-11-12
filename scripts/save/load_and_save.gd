extends Node

# TODO 存档系统

# TODO 存档系统:补充玩家类，完善存档系统

### 这个方法用来保存游戏数据
#func save_game() -> void:
	#var new_save : Save = Save.new()
#
	#ResourceSaver.save(new_save, "user://save_game_1.tres")
#
#func has_save() -> bool:
	#return FileAccess.file_exists("user://save_game_1.tres")
#
### 这个方法用来加载游戏数据
#func load_game() -> void:
	#if FileAccess.file_exists("user://save_game_1.tres"):
		#var old_save : Save = load("user://save_game_1.tres") as Save
#
#
#func save_config() -> void:
	#var new_config : Config = Config.new()
#
#
	#ResourceSaver.save(new_config, "user://config.tres")
#
#func load_config() -> void:
	#if FileAccess.file_exists("user://config.tres"):
		#var old_config : Config = load("user://config.tres") as Config
#
#
#func has_config() -> bool:
	#return FileAccess.file_exists("user://config.tres")
