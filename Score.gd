extends Node

onready var high_score = 0
onready var score = 0 setget set_score

func set_score(val: int) -> void:
	score = val
	high_score = max(score, high_score)
