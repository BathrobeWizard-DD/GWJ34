extends Camera2D

export var decay = 0.8  # How quickly the shaking stops [0, 1].

export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.

export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).


var trauma = 0.0  # Current shake strength.

var trauma_power = 2  # Trauma exponent. Use [2, 3]


func _ready():
	randomize()
	get_tree().get_nodes_in_group("centerSatellite")[0].connect("hit_by_debris", self, "add_trauma")


func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()


func add_trauma(size: int):
	trauma = min(trauma + 0.33, 1.0)


func shake():
	var amount = pow(trauma, trauma_power)
	# rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
