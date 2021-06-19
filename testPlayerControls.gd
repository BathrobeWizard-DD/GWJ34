extends Node2D

export (PackedScene) var gunProjectileScene

signal spawn_small_debris

const PITCH_SCALE_DIFFERENCE = 0.05
var _random = RandomNumberGenerator.new()

onready var _shoot_sound = $ShootSound


func _input(event):
	pass

func playerFireGun():
	if ($playerChar.readyToShoot):
		var gunProjectile = gunProjectileScene.instance()
		call_deferred('add_child', gunProjectile)
		gunProjectile.shootProjectile(
			$playerChar.position,
			$playerChar.position.direction_to(get_global_mouse_position()),
			$playerChar.get_linear_velocity()
		)
		_shoot_sound.set_pitch_scale(1 + _random.randf_range(-PITCH_SCALE_DIFFERENCE, PITCH_SCALE_DIFFERENCE))
		_shoot_sound.play()
		$playerChar.emit_signal("firedProjectile")

func _process(delta):
	if Input.is_action_pressed("click_leftbutton"):
		playerFireGun()

# Called when the node enters the scene tree for the first time.
func _ready():
	var ropeOne = get_node("RopeSegOne")
	var ropeTwo = get_node("RopeSegOne/RopeSegTwo")
	ropeOne.set_top_pin(get_node("centerSatellite"))
	ropeOne.set_bottom_pin(ropeTwo.get_node("RigidBody2D"))
	#ropeTwo.set_top_pin(ropeOne.get_node("RigidBody2D15"))
	ropeTwo.set_bottom_pin(get_node("playerChar"))

func _on_Node2D_spawn_small_debris():
	pass
