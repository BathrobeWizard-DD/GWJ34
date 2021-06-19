extends StaticBody2D

export(int) var MAX_HP = 10
export(int) var health = MAX_HP setget set_health

signal hit_by_debris

onready var texture_progress = $TextureProgress

func set_health(value: int) -> void:
	health = value
	if health == 0:
		queue_free()
	texture_progress.value = int((float(value) / MAX_HP * 100)) % 100

func _on_centerSatellite_hit_by_debris(debris_type):
	print("Satellite was hit by debris!")
	print(debris_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
