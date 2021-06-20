extends KinematicBody2D

var projSpeed = 300
var projVelocity = Vector2.ZERO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemy_projectile")
	pass # Replace with function body.

func shootProjectile(startPos, directionVector):
	position = startPos
	
	var finalSpeed = projSpeed
	projVelocity = directionVector * finalSpeed
	rotation = directionVector.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	projVelocity = move_and_slide(projVelocity)
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if (body.is_in_group("mediumDebris") or body.is_in_group("smallDebris")):
		body.emit_signal("hit_by_projectile", projVelocity)
		queue_free()
