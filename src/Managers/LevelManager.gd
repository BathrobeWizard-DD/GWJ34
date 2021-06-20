extends Node

export var debris_pause_time = 5
export var debris_wave_fequency = 10
export var debris_frequecy_change_rate = 20
export var enemy_frequecy_change_rate = 30
export var debris_frequecy_change = .2
export var enemy_frequecy_change = .5
export var max_wave_debris_amount = 8
var debris_scene_dictionary = {"medium_debris": "res://debris/mediumDebris.tscn", "small_debris": "res://debris/smallDebris.tscn"}
var spawn_table = {"type": "res://debris/mediumDebris.tscn", "amount": 2.0, "velocity": 150, "angle": null}
var wave = 0
var debri_manager

signal DebrisWave(toggle)
signal EnemyFrequency(frequecy_change)
signal DebrisFrequency(frequecy_change)


func _call_wave():
	print("pause")
	emit_signal("DebrisWave", true)
	get_node("ToggleDebrisTimer").start(debris_pause_time)
	var spawn_position_increment = 1.0/spawn_table["amount"]
	print(spawn_table["amount"])
	for enemy in spawn_table["amount"]:
		debri_manager.spawnMediumDebris(spawn_table["type"],enemy * spawn_position_increment,spawn_table["velocity"], spawn_table["angle"])
	if spawn_table["amount"] < max_wave_debris_amount:
		spawn_table["amount"] += 1

func _on_start():
	get_node("EnemyFrequencyTimer").start(enemy_frequecy_change_rate)
	get_node("DebrisFrequencyTimer").start(debris_frequecy_change_rate)
	get_node("WaveTimer").start(debris_wave_fequency)

func _on_EnemyFrequencyTimer_timeout():
	emit_signal("EnemyFrequency", enemy_frequecy_change)

func _on_DebrisFrequencyTimer_timeout():
	emit_signal("DebrisFrequency", debris_frequecy_change)

func _on_ToggleDebrisTimer_timeout():
	emit_signal("DebrisWave", false)
	get_node("WaveTimer").start(debris_wave_fequency)
