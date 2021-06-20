extends Node2D

signal spawn_small_debris

const PITCH_SCALE_DIFFERENCE = 0.05
var _random = RandomNumberGenerator.new()

onready var _shoot_sound = $ShootSound
onready var player = $playerChar

func _input(event):
	pass

func playerFireGun():
	var projectile
	match player.gun:
		"blaster":
			projectile = "standard"
		"launcher":
			projectile = "grenade"
		_:
			projectile = "standard"
			
	if (player.readyToShoot):
		var gunProjectile = load("res://playerChar/playerProjectile/" + projectile + "Projectile.tscn").instance()
		call_deferred('add_child', gunProjectile)
		if projectile == "grenade":
			gunProjectile.get_node("ExplosionController").connect("exploded", self, "on_grenade_exploded")
		gunProjectile.shootProjectile(
			player.position,
			player.position.direction_to(get_global_mouse_position()),
			player.get_linear_velocity()
		)
		_shoot_sound.set_pitch_scale(1 + _random.randf_range(-PITCH_SCALE_DIFFERENCE, PITCH_SCALE_DIFFERENCE))
		_shoot_sound.play()
		player.emit_signal("firedProjectile")

func _process(delta):
	if Input.is_action_pressed("click_leftbutton"):
		playerFireGun()

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.score = 0
	var ropeOne = get_node("RopeSegOne")
	var ropeTwo = get_node("RopeSegOne/RopeSegTwo")
	ropeOne.set_top_pin(get_node("centerSatellite"))
	ropeOne.set_bottom_pin(ropeTwo.get_node("RigidBody2D"))
	#ropeTwo.set_top_pin(ropeOne.get_node("RigidBody2D15"))
	ropeTwo.set_bottom_pin(get_node("playerChar"))

func _on_Node2D_spawn_small_debris():
	pass

func gameOver():
	get_tree().change_scene("res://levels/game_over_menu.tscn")

func _on_gameover():
	gameOver()

func _on_centerSatellite_died():
	gameOver()

func on_grenade_exploded():
	print("KABOOM")
	player.gunCooldown.start()
