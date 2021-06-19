extends Sprite

export var rotation_speed = 6.0

func _process(delta: float):
	rotation_degrees += delta * rotation_speed
