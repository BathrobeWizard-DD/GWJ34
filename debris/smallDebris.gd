extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

signal hit_by_projectile

var collisionExtents = [
	Vector2(10.489, 9.626),
	Vector2(10.155, 7.29),
	Vector2(8.319, 7.123),
	Vector2(6.15, 12.129),
	Vector2(9.487, 4.954),
	Vector2(5.316, 3.619),
	Vector2(7.652, 5.789),
	Vector2(7.819, 6.122),
	Vector2(11.657, 8.959),
	Vector2(8.987, 6.289),
	Vector2(8.82, 5.288),
	Vector2(8.82, 5.288),
]


func _ready():
	randomize()
	contact_monitor = true
	contacts_reported = 1
	add_to_group("smallDebris")
	var frame_count = $AnimatedSprite.get_sprite_frames().get_frame_count("default")
	var chosen_frame_number = (randi() % frame_count)
	var extents_properties = collisionExtents[chosen_frame_number]
	$AnimatedSprite.frame = chosen_frame_number
	$CollisionShape2D.shape.extents = extents_properties


func _destroy():
	$AnimatedSprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$DebrisExplosion.set_emitting(true)
	$DestroySound.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_debris_body_entered(body):
	if (body.name == "centerSatellite"):
		body.emit_signal("hit_by_debris", 2)
		_destroy()


func _on_debris_hit_by_projectile(projVelocity):
	_destroy()


func _on_DestroySound_finished() -> void:
	queue_free()
