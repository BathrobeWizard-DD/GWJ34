extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MAX_HP = 30
export(int) var enemyHP = MAX_HP setget set_HP, get_HP

var destinationVector = Vector2.ZERO
var screenOffset = 20

var moveSpeed = 150
var currentVelocity = Vector2.ZERO

func set_HP(inputHP):
	enemyHP = inputHP

func get_HP():
	return enemyHP

func set_destination(inputVector):
	destinationVector = inputVector

func newRandPositionWithinViewport():
	var screenSize = get_viewport_rect().size
	return Vector2(
		randf() * (screenSize.x - screenOffset) + (screenOffset/2),
		randf() * (screenSize.y - screenOffset) + (screenOffset/2)
	)

# Called when the node enters the scene tree for the first time.
func _ready():
	var randomPosition = newRandPositionWithinViewport()
	set_destination(randomPosition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	currentVelocity = position.direction_to(destinationVector) * moveSpeed
	
	if (position.distance_to(destinationVector) > 5):
		currentVelocity = move_and_slide(currentVelocity)
	else:
		set_destination(newRandPositionWithinViewport())


func _on_debrisDetectArea_body_entered(body):
	if (body.is_in_group("mediumDebris")):
		print("Med. debris - shoot it.")
	elif (body.is_in_group("smallDebris")):
		print("Small debris - shoot it.")
	pass # Replace with function body.
