extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projSpeed = 500
var projVelocity = Vector2.ZERO
var angleThreshold = PI / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player_projectile")
	pass # Replace with function body.

func shootProjectile(startPos, directionVector, shooterVelocity):
	position = startPos
	
	var angleBetweenShotandShooter = abs(directionVector.angle_to(shooterVelocity))
	var additionalSpeed = 0
	if (angleBetweenShotandShooter < angleThreshold):
		additionalSpeed = directionVector.dot(shooterVelocity)
	
	var finalSpeed = projSpeed + additionalSpeed
	projVelocity = directionVector * finalSpeed
	rotation = directionVector.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	projVelocity = move_and_slide(projVelocity)
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if (body.is_in_group("mediumDebris") or body.is_in_group("smallDebris")):
		Score.score += 100 * body.score_mult
		body.emit_signal("hit_by_projectile", projVelocity)
		queue_free()
	elif (body.is_in_group("enemy")):
		Score.score += 100 * body.score_mult
		body.emit_signal("hit_by_projectile")
		queue_free()
