extends Node

onready var wave_timer = get_node("WaveTimer")
var debris_scene_dictionary = {"medium_debris": "res://debris/mediumDebris.tscn", "small_debris": "res://debris/smallDebris.tscn"}
var spawn_table = {1: {0: {"time_interval": 1.0, "enemies": {1: {"type": "res://debris/mediumDebris.tscn", "position": 0.3, "velocity": null, "angle": null},
															2: {"type": "res://debris/mediumDebris.tscn", "position": 0.35, "velocity": null, "angle": null}}}}}
var level = 1
var wave = 0
var debri_manager

signal level_over()

func setup_wave_timer():
	wave_timer.start(spawn_table[level][wave]["time_interval"])

func _call_wave():
	var dict_temp = spawn_table[level][wave]["enemies"]
	for enemy in spawn_table[level][wave]["enemies"]:
		debri_manager.spawnMediumDebris(dict_temp[enemy]["type"],dict_temp[enemy]["position"],dict_temp[enemy]["velocity"],dict_temp[enemy]["angle"])
	wave += 1
	if spawn_table[level].has(wave):
		setup_wave_timer()
	else:
		emit_signal("level_over")

func _on_level_start(level_given):
	self.level = level
	setup_wave_timer()
