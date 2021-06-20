extends Node
export var debris_frequecy_change_rate = 20
export var enemy_frequecy_change_rate = 30
export var debris_frequecy_change = .2
export var enemy_frequecy_change = .5
onready var wave_timer = get_node("WaveTimer")
var debris_scene_dictionary = {"medium_debris": "res://debris/mediumDebris.tscn", "small_debris": "res://debris/smallDebris.tscn"}
var spawn_table = {1: {"time_interval": 1.0, "enemies": {1: {"type": "res://debris/mediumDebris.tscn", "position": 0.3, "velocity": null, "angle": null},
															2: {"type": "res://debris/mediumDebris.tscn", "position": 0.35, "velocity": null, "angle": null}}}}
var wave = 0
var debri_manager

signal EnemyFrequency(frequecy_change)
signal DebrisFrequency(frequecy_change)

func _ready():
	get_node("EnemyFrequencyTimer").start(enemy_frequecy_change_rate)
	get_node("DebrisFrequencyTimer").start(debris_frequecy_change_rate)

func setup_wave_timer():
	wave_timer.start(spawn_table[wave]["time_interval"])

func _call_wave():
	var dict_temp = spawn_table[wave]["enemies"]
	for enemy in spawn_table[wave]["enemies"]:
		debri_manager.spawnMediumDebris(dict_temp[enemy]["type"],dict_temp[enemy]["position"],dict_temp[enemy]["velocity"],dict_temp[enemy]["angle"])
	wave += 1
	if spawn_table.has(wave):
		setup_wave_timer()

func _on_start():
	#setup_wave_timer()
	pass

func _on_EnemyFrequencyTimer_timeout():
	emit_signal("EnemyFrequency", enemy_frequecy_change)

func _on_DebrisFrequencyTimer_timeout():
	emit_signal("DebrisFrequency", debris_frequecy_change)
