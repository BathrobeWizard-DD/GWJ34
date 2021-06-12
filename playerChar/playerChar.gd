extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxSpeed = 400.0 # pixels per second
var acceleration = 10 # pixels per second^2
var currentVelocity = Vector2.ZERO
var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	# Doing it like this allows for moving diagonally
	# and for opposing directions to cancel each other out.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * maxSpeed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
