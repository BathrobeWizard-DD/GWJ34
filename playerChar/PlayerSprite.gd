extends Node2D

onready var body = $Body
onready var head = $Head
onready var ear = $RightEar
onready var gun = $Gun

onready var previous_pos = Vector2.ZERO

onready var lookup = [
		Vector2.DOWN,
		Vector2.LEFT + Vector2.DOWN,
		Vector2.LEFT,
		Vector2.UP + Vector2.LEFT,
		Vector2.UP,
		Vector2.RIGHT + Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN + Vector2.RIGHT,
]

func _process(_delta):
	if global_position != previous_pos:
		var movedir = global_position.direction_to(previous_pos)
		previous_pos = global_position
	
		var record_i = 0
		var record_d = INF
		for i in range(len(lookup)):
			var dist = lookup[i].distance_to(movedir)
			if dist < record_d:
				record_i = i
				record_d = dist
		head.frame = record_i
		body.frame = record_i
	
	var gun_angle = (get_global_mouse_position() - global_position).angle()
#	print(rad2deg(gun_angle))
	gun.rotation = gun_angle
	gun.flip_v = gun_angle > PI/2 || gun_angle < -PI/2
