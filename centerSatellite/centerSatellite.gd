extends StaticBody2D

export(int) var MAX_HP = 10
export(int) var health = MAX_HP setget set_health

onready var texture_progress = $TextureProgress
		
func set_health(value: int) -> void:
	health = value
	if health == 0:
		queue_free()
	texture_progress.value = int((float(value) / MAX_HP * 100)) % 100
