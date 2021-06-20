extends Node2D

signal spawn_small_debris
signal level_start()

const PITCH_SCALE_DIFFERENCE = 0.05
var _random = RandomNumberGenerator.new()

onready var _shoot_sound = $ShootSound
onready var player = $playerChar

onready var grenadeCooldown = $playerHPBar/GrenadeCooldown

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
		var gunProjectile = load("res://playerChar/playerProjectile/standardProjectile.tscn").instance()
		call_deferred('add_child', gunProjectile)
		gunProjectile.shootProjectile(
			player.position,
			player.position.direction_to(get_global_mouse_position()),
			player.get_linear_velocity()
		)
		_shoot_sound.set_pitch_scale(1 + _random.randf_range(-PITCH_SCALE_DIFFERENCE, PITCH_SCALE_DIFFERENCE))
		_shoot_sound.play()
		player.emit_signal("firedProjectile")

func playerFireNade():
	if player.readyToNade:
		var grenade = load("res://playerChar/playerProjectile/grenadeProjectile.tscn").instance()
		call_deferred('add_child', grenade)
		grenade.get_node("ExplosionController").connect("exploded", self, "on_grenade_exploded")
		grenade.shootProjectile(
			player.position,
			player.position.direction_to(get_global_mouse_position()),
			player.get_linear_velocity()
		)
		_shoot_sound.set_pitch_scale(1 + _random.randf_range(-PITCH_SCALE_DIFFERENCE, PITCH_SCALE_DIFFERENCE))
		_shoot_sound.play()
		player.launch_grenade()
	else:
		grenadeCooldown.blink()

func _process(delta):
	grenadeCooldown.set_value(100 - (player.grenadeCooldown.time_left / player.grenadeCooldown.wait_time * 100))
	if Input.is_action_pressed("click_leftbutton"):
		playerFireGun()
	if Input.is_action_pressed("click_rightbutton"):
		playerFireNade()

# Called when the node enters the scene tree for the first time.
func _ready():

	EnemyWaveManager.debri_manager = get_node("mediumDebrisManager")
	self.connect("level_start", EnemyWaveManager, "_on_start")
	EnemyWaveManager.connect("DebrisFrequency", get_node("mediumDebrisManager"), "_on_frquency_change")
	EnemyWaveManager.connect("DebrisWave", get_node("mediumDebrisManager"), "_on_wave")
	Score.score = 0
	var ropeOne = get_node("RopeSegOne")
	var ropeTwo = get_node("RopeSegOne/RopeSegTwo")
	ropeOne.set_top_pin(get_node("centerSatellite"))
	ropeOne.set_bottom_pin(ropeTwo.get_node("RigidBody2D"))
	#ropeTwo.set_top_pin(ropeOne.get_node("RigidBody2D15"))
	ropeTwo.set_bottom_pin(get_node("playerChar"))
	emit_signal("level_start")

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
