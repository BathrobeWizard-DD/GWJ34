extends Node2D

onready var body = $Body
onready var head = $Head
onready var left_ear = $Ears/LeftEar
onready var right_ear = $Ears/RightEar
onready var gun = $Gun

onready var left_original = left_ear.position
onready var right_original = right_ear.position

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
#	if global_position != previous_pos:
	previous_pos = global_position

	var gun_dir = (get_global_mouse_position() - global_position).normalized()
	var record_i = 0
	var record_d = INF
	for i in range(len(lookup)):
		var dist = lookup[i].distance_to(gun_dir)
		if dist < record_d:
			record_i = i
			record_d = dist
	head.frame = record_i
	body.frame = record_i
	$Ears.rotation = gun_dir.angle() - PI/2

	var gun_angle = gun_dir.angle()
#	print(rad2deg(gun_angle))
	gun.rotation = gun_angle
	gun.flip_v = gun_angle > PI/2 || gun_angle < -PI/2
