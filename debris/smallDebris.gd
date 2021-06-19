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

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_debris_body_entered(body):
	if (body.name == "centerSatellite"):
		pass


func _on_debris_hit_by_projectile(projVelocity):
	queue_free()
	pass # Replace with function body.
