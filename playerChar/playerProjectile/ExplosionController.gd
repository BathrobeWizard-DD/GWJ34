extends Node2D

export(PackedScene) var explosion
signal exploded

onready var radius = $Radius
onready var timer = $Timer

func explode():
	var bodies = radius.get_overlapping_bodies()
	if bodies.size() > 0:
		for body in bodies:
			if "Debris" in body.name:
				Score.score += 100 * body.score_mult
				body.emit_signal("hit_by_projectile", get_parent().projVelocity)
	var explosion_particles = explosion.instance()
	get_node("/root/Node2D").call_deferred("add_child" ,explosion_particles)
	explosion_particles.global_position = global_position
	explosion_particles.emitting = true
	emit_signal("exploded")
	get_parent().queue_free()


func _on_Timer_timeout():
	explode()
