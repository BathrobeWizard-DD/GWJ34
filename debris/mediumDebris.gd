extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

export (PackedScene) var smallDebrisScene

const destroy_particles = preload("res://debris/DebrisExplosion.tscn")

signal hit_by_projectile

var collisionExtents = [
	Vector2(11.9, 9.985),
	Vector2(11.9, 9.985),
	Vector2(8.114, 6.421),
	Vector2(10.564, 8.537),
	Vector2(10.564, 8.537),
	Vector2(11.232, 11.321)
]


func _ready():
	randomize()
	contact_monitor = true
	contacts_reported = 1
	add_to_group("mediumDebris")
	var frame_count = $AnimatedSprite.get_sprite_frames().get_frame_count("default")
	var chosen_frame_number = (randi() % frame_count)
	
	var extents_properties = collisionExtents[chosen_frame_number] * 1.5
	
	$AnimatedSprite.set_frame(chosen_frame_number)
	$CollisionShape2D.shape.set_extents(extents_properties)

func _destroy():
	$AnimatedSprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$HitSound.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_debris_body_entered(body):
	if (body.name == "centerSatellite"):
		body.emit_signal("hit_by_debris", 10)
		
		var destroyed_vfx = destroy_particles.instance()
		destroyed_vfx.set_global_position(get_global_position())
		destroyed_vfx.set_emitting(true)
		get_parent().add_child(destroyed_vfx)
		_destroy()

func spawn_small_debris(inputVelocity):
	var smallDebrisPiece = smallDebrisScene.instance()
	smallDebrisPiece.position = position + inputVelocity.normalized()
	smallDebrisPiece.linear_velocity = inputVelocity.clamped(max_speed)
	
	get_node("/root/Node2D").call_deferred("add_child" ,smallDebrisPiece)

func _on_debris_hit_by_projectile(projVelocity):
	# spawn the small debris.
	var angleToProjVelocity = -(linear_velocity.angle_to(projVelocity))
	
	spawn_small_debris((projVelocity * 0.2).rotated(-PI/6))
	spawn_small_debris((projVelocity * 0.2))
	spawn_small_debris((projVelocity * 0.2).rotated(PI/6))
	
	_destroy()



func _on_HitSound_finished() -> void:
	queue_free()
