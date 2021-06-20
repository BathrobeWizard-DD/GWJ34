extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var enemyProjectileScene

var destinationVector = Vector2.ZERO
var screenOffset = 20

var moveSpeed = 150
var currentVelocity = Vector2.ZERO

var score_mult = 4

signal hit_by_projectile

func set_destination(inputVector):
	destinationVector = inputVector

func newRandPositionWithinViewport():
	var screenSize = get_viewport_rect().size
	return Vector2(
		randf() * (screenSize.x - screenOffset) + (screenOffset/2),
		randf() * (screenSize.y - screenOffset) + (screenOffset/2)
	)

func fireProjectile(targetPosition):
	var enemyProjectile = enemyProjectileScene.instance()
	enemyProjectile.shootProjectile(
		position,
		position.direction_to(targetPosition).normalized()
	)
	
	get_node("/root/Node2D").call_deferred('add_child', enemyProjectile)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemy")
	var randomPosition = newRandPositionWithinViewport()
	$shootTimer.start()
	set_destination(randomPosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition = get_node("/root/Node2D/playerChar").position
	var angleToPlayer = get_angle_to(playerPosition)

func _physics_process(delta):
	currentVelocity = position.direction_to(destinationVector) * moveSpeed
	
	if (position.distance_to(destinationVector) > 5):
		currentVelocity = move_and_slide(currentVelocity)
	else:
		set_destination(newRandPositionWithinViewport())


func _on_debrisDetectArea_body_entered(body):
	if (body.is_in_group("mediumDebris")):
		fireProjectile(body.position)
	elif (body.is_in_group("smallDebris")):
		fireProjectile(body.position)
	pass # Replace with function body.


func _on_shootTimer_timeout():
	fireProjectile(get_node("/root/Node2D/playerChar").position)


func _on_enemy_hit_by_projectile():
	queue_free()
