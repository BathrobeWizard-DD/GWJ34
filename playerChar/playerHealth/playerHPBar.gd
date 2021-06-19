extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.value = $TextureProgress.max_value
	pass # Replace with function body.

func setHPValue(inputValue):
	$TextureProgress.value = inputValue

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
