extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

signal hit_by_projectile

var image_path_template = "res://assets/sprites/debris/debris_%d.png"
var collisionExtents = [
	Vector2(11.9, 9.985),
	Vector2(14.461, 11.544),
	Vector2(8.559, 6.978),
	Vector2(11.677, 8.426),
	Vector2(11.677, 8.426),
	Vector2(11.009, 9.651)
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_to_group("debris")
	var chosen_frame_number = (randi() % 6)
	var image_path = image_path_template % (chosen_frame_number+1)
	
	var extents_properties = collisionExtents[chosen_frame_number]
	
	$Sprite.set_texture(load(image_path))
	$CollisionShape2D.shape.set_extents(extents_properties)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_debris_body_entered(body):
	print("Something has entered debris's body:")
	print(body)


func _on_debris_hit_by_projectile():
	queue_free()
	pass # Replace with function body.
