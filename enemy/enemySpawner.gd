extends Node2D

export (PackedScene) var enemyScene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func spawnEnemy():
	var spawnLocation = $spawnPath/spawnLocation
	spawnLocation.unit_offset = randf()
	
	var enemyInstance = enemyScene.instance()
	enemyInstance.position = spawnLocation.position
	
	call_deferred("add_child", enemyInstance)

# Called when the node enters the scene tree for the first time.
func _ready():
	$spawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawnTimer_timeout():
	spawnEnemy()
