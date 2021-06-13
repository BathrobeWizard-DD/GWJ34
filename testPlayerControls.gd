extends Node2D

export (PackedScene) var gunProjectileScene

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
