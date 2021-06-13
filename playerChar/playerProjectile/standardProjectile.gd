extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projSpeed = 500
var projVelocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shootProjectile(startPos, directionVector):
	position = startPos
	projVelocity = directionVector * projSpeed
	rotation = directionVector.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	projVelocity = move_and_slide(projVelocity)
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
