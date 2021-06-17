extends Node

onready var wave_timer = get_node("WaveTimer")
var debris_scene_dictionary = {"medium_debris": "res://debris/mediumDebris.tscn"}
var spawn_table = {1: {1: {}}}
var level = 0
var wave = 0

func setup_wave_timer():
	wave_timer.start(spawn_table[level][wave]["time_interval"])

#function that the Timer signal calls
func _call_wave():
	pass

func _on_start(level_given):
	self.level = level
	setup_wave_timer()
