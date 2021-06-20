extends Sprite

signal health()

func _ready():
	position = Vector2(350,350)

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "playerChar":
		self.queue_free()
