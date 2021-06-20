extends CPUParticles2D


func _ready() -> void:
	emitting = true
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
