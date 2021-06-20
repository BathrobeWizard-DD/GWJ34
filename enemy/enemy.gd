extends KinematicBody2D

export (PackedScene) var enemyProjectileScene

const death_effect = preload("res://enemy/AlienDeath.tscn")

var health = 2

var destinationVector = Vector2.ZERO
var screenOffset = 20

var moveSpeed = 150
var currentVelocity = Vector2.ZERO

var score_mult = 4

onready var lookup = [
		Vector2.DOWN,
		Vector2.LEFT + Vector2.DOWN,
		Vector2.LEFT,
		Vector2.UP + Vector2.LEFT,
		Vector2.UP,
		Vector2.RIGHT + Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN + Vector2.RIGHT,
]

onready var sprite = $AnimatedSprite

signal hit_by_projectile

onready var shoot_sound = $ShootSound
onready var hit_sound = $HitSound

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
	shoot_sound.play()
	get_node("/root/Node2D").call_deferred('add_child', enemyProjectile)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemy")
	var randomPosition = newRandPositionWithinViewport()
	set_destination(randomPosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerPosition = get_node("/root/Node2D/playerChar").position
	var gun_dir = (playerPosition - position).normalized()
	var angleToPlayer = get_angle_to(playerPosition)

	var record_i = 0
	var record_d = INF
	for i in range(len(lookup)):
		var dist = lookup[i].distance_to(gun_dir)
		if dist < record_d:
			record_i = i
			record_d = dist
	sprite.frame = record_i
	$GunSprite.rotation = angleToPlayer
	$GunSprite.flip_v = angleToPlayer > PI/2 || angleToPlayer < -PI/2

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
	if health > 1:
		health -= 1
		hit_sound.play()
	else:
		var vfx = death_effect.instance()
		vfx.set_global_position(get_global_position())
		vfx.set_emitting(true)
		get_tree().get_root().get_node("Node2D").add_child(vfx)
		queue_free()
