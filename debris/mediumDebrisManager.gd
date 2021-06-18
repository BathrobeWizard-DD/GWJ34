extends Node2D

export (PackedScene) var debrisScene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mediumDebrisInstances = []

func spawnMediumDebris():
	var debrisSpawnLocation = $debrisPath/debrisSpawnLocation
	debrisSpawnLocation.unit_offset = randf()
	
	var debrisPiece = debrisScene.instance()
	
	debrisPiece.position = debrisSpawnLocation.position
	
	var angle = debrisSpawnLocation.rotation + (PI / 2)
	angle += rand_range(-PI / 4, PI / 4)
	debrisPiece.rotation = angle
	
	var velocity = Vector2(rand_range(debrisPiece.min_speed, debrisPiece.max_speed), 0)
	debrisPiece.linear_velocity = velocity.rotated(angle)
	
	mediumDebrisInstances.append(debrisPiece)
	add_child(debrisPiece)

# Called when the node enters the scene tree for the first time.
func _ready():
	$debrisSpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_debrisSpawnTimer_timeout():
	spawnMediumDebris()
