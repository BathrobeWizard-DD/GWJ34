extends Node2D

export (PackedScene) var gunProjectileScene
export (PackedScene) var debrisScene

signal spawn_small_debris

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(event):
	if event.is_action_pressed("click_leftbutton"):
		var gunProjectile = gunProjectileScene.instance()
		add_child(gunProjectile)
		
		gunProjectile.shootProjectile(
			$playerChar.position,
			$playerChar.position.direction_to(get_global_mouse_position()),
			$playerChar.get_linear_velocity()
		)

# Called when the node enters the scene tree for the first time.
func _ready():
	var ropeOne = get_node("RopeSegOne")
	var ropeTwo = get_node("RopeSegOne/RopeSegTwo")
	ropeOne.set_top_pin(get_node("centerSatellite"))
	ropeOne.set_bottom_pin(ropeTwo.get_node("RigidBody2D"))
	#ropeTwo.set_top_pin(ropeOne.get_node("RigidBody2D15"))
	ropeTwo.set_bottom_pin(get_node("playerChar"))
	
	$debrisSpawnTimer.start()

func _on_debrisSpawnTimer_timeout():
	var debrisSpawnLocation = $debrisPath/debrisSpawnLocation
	debrisSpawnLocation.unit_offset = randf()
	
	var debrisPiece = debrisScene.instance()
	add_child(debrisPiece)
	
	debrisPiece.position = debrisSpawnLocation.position
	
	var angle = debrisSpawnLocation.rotation + (PI / 2)
	angle += rand_range(-PI / 4, PI / 4)
	debrisPiece.rotation = angle
	
	var velocity = Vector2(rand_range(debrisPiece.min_speed, debrisPiece.max_speed), 0)
	debrisPiece.linear_velocity = velocity.rotated(angle)


func _on_Node2D_spawn_small_debris():
	print("Small debris shoould be spawned.")
	pass # Replace with function body.
