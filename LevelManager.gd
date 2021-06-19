extends Node

onready var wave_timer = get_node("WaveTimer")
var debris_scene_dictionary = {"medium_debris": "res://debris/mediumDebris.tscn", "small_debris": "res://debris/smallDebris.tscn"}
var spawn_table = {1: {1: {"type": "", "position": "", "time_interval": "", "velocity": "", "angle": ""}}}
var level = 0
var wave = 0
var debri_manager

func setup_wave_timer():
	wave_timer.start(spawn_table[level][wave]["time_interval"])

func _call_wave():
	debri_manager.spawnMediumDebris()
	pass

func _on_level_start(level_given):
	self.level = level
	setup_wave_timer()
