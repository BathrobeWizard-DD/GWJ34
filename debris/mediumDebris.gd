extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

export (PackedScene) var smallDebrisScene

signal hit_by_projectile

var collisionExtents = [
	Vector2(11.9, 9.985),
	Vector2(11.9, 9.985),
	Vector2(8.114, 6.421),
	Vector2(10.564, 8.537),
	Vector2(10.564, 8.537),
	Vector2(11.232, 11.321)
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_to_group("mediumDebris")
	var frame_count = $AnimatedSprite.get_sprite_frames().get_frame_count("default")
	var chosen_frame_number = (randi() % frame_count)
	
	var extents_properties = collisionExtents[chosen_frame_number]
	
	$AnimatedSprite.set_frame(chosen_frame_number)
	$CollisionShape2D.shape.set_extents(extents_properties)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_debris_body_entered(body):
	print(body)
	
func _on_debris_hit_by_projectile(projVelocity):
	# spawn the small debris.
	var angleToProjVelocity = linear_velocity.angle_to(projVelocity)
	
	var smallDebrisPiece = smallDebrisScene.instance()
	smallDebrisPiece.position = position
	smallDebrisPiece.linear_velocity = (projVelocity / 2)
	get_node("/root/Node2D").add_child(smallDebrisPiece)
	
	queue_free()
