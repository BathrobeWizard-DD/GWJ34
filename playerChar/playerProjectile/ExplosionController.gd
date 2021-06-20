extends Node2D

signal exploded

onready var radius = $Radius

func _input(event):
	if event.is_action_released("click_leftbutton"):
		explode()

func explode():
	var bodies = radius.get_overlapping_bodies()
	if bodies.size() > 0:
		print(bodies)
		for body in bodies:
			if "debris" in body.name:
				print("OH NO")
	emit_signal("exploded")
	get_parent().queue_free()
