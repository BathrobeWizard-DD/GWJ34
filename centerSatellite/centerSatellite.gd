extends StaticBody2D

export(int) var MAX_HP = 200
export(int) var health = MAX_HP setget set_health, get_health

signal hit_by_debris

onready var texture_progress = $TextureProgress

func set_health(value: int) -> void:
	health = value
	if health == 0:
		queue_free()
	texture_progress.value = health

func get_health():
	return health

func _on_centerSatellite_hit_by_debris(healthDecrease):
	var new_health = get_health() - healthDecrease
	if (new_health <= 0):
		print("Should trigger lose here.")
		pass
	set_health(new_health)

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_progress.max_value = MAX_HP
	texture_progress.value = MAX_HP
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
