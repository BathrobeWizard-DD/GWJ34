extends Node2D

export (PackedScene) var enemyScene

export var spawnInterval = 6

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wave = 0

func spawnEnemy():
	var spawnLocation = $spawnPath/spawnLocation
	spawnLocation.unit_offset = randf()
	
	var enemyInstance = enemyScene.instance()
	enemyInstance.position = spawnLocation.position
	
	call_deferred("add_child", enemyInstance)

# Called when the node enters the scene tree for the first time.
func _ready():
	$spawnTimer.wait_time = spawnInterval
	$spawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawnTimer_timeout():
	spawnEnemy()
	
	if wave > 4:
		spawnEnemy()
		
	if wave > 10:
		spawnEnemy()

	wave += 1
