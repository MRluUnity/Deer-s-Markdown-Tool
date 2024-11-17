#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node
# TODO 拼音类 ===============>信 号<===============
#region 信号

#endregion

# TODO 拼音类 ===============>常 量<===============
#region 常量
const SHENG_MU : Array[String] = ["b", "p", "m", "f", "g", "k", "h", "j", "q", "x", "z", "c", "s", "d", "t", "n", "l", "r", "y", "w"]
#endregion

# TODO 拼音类 ===============>变 量<===============
#region 变量
# 拼音类：汉字拼音字典
static var pinyin_dict : Dictionary = {}
#endregion

# TODO 拼音类 ===============>虚方法<===============
#region 常用的虚方法
func _ready() -> void:
	load_pinyin_file("res://scripts/pin_yin_model/cedict.json")
#endregion

# TODO 拼音类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 拼音类 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 拼音类：加载拼音文件
func load_pinyin_file(file_path) -> void:
	if pinyin_dict: return
	var file = FileAccess.open(file_path, FileAccess.READ)

	if file == null:
		file.close()
		return

	var pinyin_array : Array = JSON.parse_string(file.get_as_text())
	file.close()
	for item in pinyin_array:
		pinyin_dict[item["simplified"]] = item["pinyin"]

# TODO_FUC 拼音类：获取拼音
func get_pinyin(text : String) -> String:
	var result : String = ""
	for c in text:
		if pinyin_dict.has(c):
			result += pinyin_dict[c] + " "
		else:
			result += c + " "
	return result.strip_edges()

# TODO_FUC 拼音类：解析拼音的声母韵母
func pinyin_parse(pinyin : String, min_speak_speed : float = .1, max_speak_speed : float = .15) -> void:
	for i in pinyin.split(" "):
		var audio_path : String
		if i[0] == "a":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/a.wav"
			elif i[1] == "o":
				audio_path = "res://scripts/pin_yin_model/audios/ao.wav"
			elif i[1] == "i":
				audio_path = "res://scripts/pin_yin_model/audios/ai.wav"
			elif i[1] == "n":
				if i[2] == "g":
					audio_path = "res://scripts/pin_yin_model/audios/ang.wav"
				else :
					audio_path = "res://scripts/pin_yin_model/audios/an.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/a.wav"
		elif i[0] == "e":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/e.wav"
			elif i[1] == "i":
				audio_path = "res://scripts/pin_yin_model/audios/ei.wav"
			elif i[1] == "r":
				audio_path = "res://scripts/pin_yin_model/audios/er.wav"
			elif i[1] == "n":
				if i[2] == "g":
					audio_path = "res://scripts/pin_yin_model/audios/eng.wav"
				else :
					audio_path = "res://scripts/pin_yin_model/audios/en.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/e.wav"
		elif i[0] == "o":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/o.wav"
			elif i[1] == "u":
				audio_path = "res://scripts/pin_yin_model/audios/ou.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/o.wav"
		elif i[0] == "z":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/z.wav"
			elif i[1] == "h":
				audio_path = "res://scripts/pin_yin_model/audios/zh.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/z.wav"
		elif i[0] == "c":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/c.wav"
			elif i[1] == "h":
				audio_path = "res://scripts/pin_yin_model/audios/ch.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/c.wav"
		elif i[0] == "s":
			if i.length() == 1:
				audio_path = "res://scripts/pin_yin_model/audios/s.wav"
			elif i[1] == "h":
				audio_path = "res://scripts/pin_yin_model/audios/sh.wav"
			else :
				audio_path = "res://scripts/pin_yin_model/audios/s.wav"
		elif i[0] in SHENG_MU:
			audio_path = "res://scripts/pin_yin_model/audios/" + i[0] + ".wav"
		else :
			audio_path = ""
		if audio_path != "":
			create_audio(load(audio_path))

		await get_tree().create_timer(randf_range(min_speak_speed, max_speak_speed)).timeout

# TODO_FUC 拼音类：创建音频播放器并播放音频
func create_audio(wav : AudioStreamWAV, audio_bus : StringName = "Master",min_pitch : float = .9, max_pitch : float = 1.4) -> void:
	var audio : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	add_child(audio)
	audio.stream = wav
	audio.bus = audio_bus
	audio.pitch_scale = randf_range(min_pitch, max_pitch)
	audio.play()
	audio.finished.connect(func(): audio.queue_free())
#endregion
