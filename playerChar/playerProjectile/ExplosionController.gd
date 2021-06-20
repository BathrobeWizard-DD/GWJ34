extends Node2D

signal exploded

onready var radius = $Radius

func _input(event):
	if event.is_action_released("click_leftbutton"):
		explode()

func explode():
	var bodies = radius.get_overlapping_bodies()
	if bodies.size() > 0:
		for body in bodies:
			if "Debris" in body.name:
				Score.score += 100 * body.score_mult
				body.emit_signal("hit_by_projectile", get_parent().projVelocity)
	emit_signal("exploded")
	get_parent().queue_free()
