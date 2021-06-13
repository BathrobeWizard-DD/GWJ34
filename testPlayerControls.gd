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
	var ropeOne = get_node("RopeSegOne")
	var ropeTwo = get_node("RopeSegOne/RopeSegTwo")
	ropeOne.set_top_pin(get_node("StaticBody2D"))
	ropeOne.set_bottom_pin(ropeTwo.get_node("RigidBody2D"))
	#ropeTwo.set_top_pin(ropeOne.get_node("RigidBody2D15"))
	ropeTwo.set_bottom_pin(get_node("playerChar"))
