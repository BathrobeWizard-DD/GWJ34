extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var maxSpeed = 200.0 # pixels per second
export var accelerationScalar = 50 # pixels per second^2
export var brakeFactor = 10.0
var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(0.0)
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func get_input():
	var changeInVelocity = Vector2.ZERO
	var finalAccel = Vector2.ZERO
	var directionPressed = false
	# Doing it like this allows for moving diagonally
	# and for opposing directions to cancel each other out.
	if Input.is_action_pressed("move_right"):
		changeInVelocity.x += 1
		directionPressed = true
	if Input.is_action_pressed("move_left"):
		changeInVelocity.x -= 1
		directionPressed = true
	if Input.is_action_pressed("move_down"):
		changeInVelocity.y += 1
		directionPressed = true
	if Input.is_action_pressed("move_up"):
		changeInVelocity.y -= 1
		directionPressed = true
	
	if Input.is_action_pressed("click_rightbutton"):
		set_linear_damp(brakeFactor)
	elif Input.is_action_just_released("click_rightbutton"):
		set_linear_damp(0.0)
	elif (directionPressed):
		finalAccel = (changeInVelocity.normalized() * accelerationScalar)
		apply_central_impulse(finalAccel)

func _integrate_forces(state):
	pass

func _physics_process(_delta):
	get_input()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	get_input()
