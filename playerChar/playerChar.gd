extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum States {NoControl, Moving, Braking}
export var maxSpeed = 200.0 # pixels per second
export var accelerationScalar = 80 # pixels per second^2
export var brakeFactor = 10.0
var directionVector = Vector2.ZERO
var screen_size = Vector2.ZERO
var currentState = null

# Called when the node enters the scene tree for the first time.
func _ready():
	currentState = States.NoControl
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func get_input():
	directionVector = Vector2.ZERO
	var directionPressed = false
	
	if Input.is_action_pressed("click_rightbutton"):
		currentState = States.Braking
	else:
		# Doing it like this allows for moving diagonally
		# and for opposing directions to cancel each other out.
		if Input.is_action_pressed("move_right"):
			directionVector.x += 1
			directionPressed = true
		if Input.is_action_pressed("move_left"):
			directionVector.x -= 1
			directionPressed = true
		if Input.is_action_pressed("move_down"):
			directionVector.y += 1
			directionPressed = true
		if Input.is_action_pressed("move_up"):
			directionVector.y -= 1
			directionPressed = true
		
		if (directionPressed):
			currentState = States.Moving
		else:
			currentState = States.NoControl

func _integrate_forces(state):
	pass

func _physics_process(_delta):
	get_input()
	
	match currentState:
		States.Braking:
			set_linear_damp(brakeFactor)
		States.Moving:
			set_linear_damp(0.0)
			var finalAccel = (directionVector.normalized() * accelerationScalar)
			apply_central_impulse(finalAccel)
		States.NoControl:
			set_linear_damp(0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	get_input()
