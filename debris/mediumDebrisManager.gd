extends Node2D

export var spawn_frequency = 2.5
export (PackedScene) var debrisScene
var mediumDebrisInstances = []

func spawnMediumDebris(debris_given = null, position_given = null, velocity_given = null, angle_given = null):
	
	var debrisSpawnLocation = $debrisPath/debrisSpawnLocation
	var debrisPiece
	var angle 
	var velocity
	
	#Logic to determine arguments
	#Debris type
	if debris_given == null:
		debrisPiece = debrisScene.instance()
	else:
		debrisPiece = load(debris_given).instance()
	#Position on Path
	if position_given == null:
		debrisSpawnLocation.unit_offset = randf()
		debrisPiece.position = debrisSpawnLocation.position
	else:
		debrisSpawnLocation.unit_offset = position_given
		debrisPiece.position = debrisSpawnLocation.position
	#Angle of the vector
	if angle_given == null:
		angle = debrisSpawnLocation.rotation + (PI / 2) + rand_range(-PI / 4, PI / 4)
		debrisPiece.rotation = angle
	else:
		angle = debrisSpawnLocation.rotation + (PI / 2) + angle_given
		debrisPiece.rotation = angle
	#Velocity of the vector
	if velocity_given == null:
		velocity = Vector2(rand_range(debrisPiece.min_speed, debrisPiece.max_speed), 0)
		debrisPiece.linear_velocity = velocity.rotated(angle)
	else:
		debrisPiece.linear_velocity = Vector2(velocity_given, 0).rotated(angle)
	
	mediumDebrisInstances.append(debrisPiece)
	add_child(debrisPiece)

# Called when the node enters the scene tree for the first time.
func _ready():
	$debrisSpawnTimer.start(2.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_wave(toggle):
	get_node("debrisSpawnTimer").set_paused(toggle)

func _on_debrisSpawnTimer_timeout():
	spawnMediumDebris()

func _on_frquency_change(frequency_change):
	spawn_frequency -= frequency_change
	if spawn_frequency <= 0:
		spawn_frequency = 0.5
	get_node("debrisSpawnTimer").set_wait_time(spawn_frequency)
