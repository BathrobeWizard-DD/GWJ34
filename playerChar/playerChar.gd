extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var maxSpeed = 300.0 # pixels per second
export var accelerationScalar = 30 # pixels per second^2
var currentVelocity = Vector2.ZERO
var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func get_input():
	var changeInVelocity = Vector2.ZERO
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
	
	if (directionPressed):
		currentVelocity += (changeInVelocity.normalized() * accelerationScalar).clamped(maxSpeed)

func _physics_process(_delta):
	get_input()
	currentVelocity = move_and_slide(currentVelocity.clamped(maxSpeed))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
