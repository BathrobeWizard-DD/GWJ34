extends Node2D

export(int) var offset := 2
export(int) var piece_size := 4

onready var prev_point = Vector2.ZERO
onready var point = Vector2.ZERO

onready var prev_point2 = Vector2.ZERO
onready var point2 = Vector2.ZERO

onready var points := [
		[Vector2.ZERO, Vector2.ZERO],
		[Vector2.ZERO, Vector2.ZERO],
		[Vector2.ZERO, Vector2.ZERO],
		[Vector2.ZERO, Vector2.ZERO],
]

func _process(_delta):
	for i in range(len(points)):
		if i == 0:
			points[i][0] = points[i][1]
			points[i][1] = to_global(position + Vector2(0, -i * offset))
			continue
		points[i][0] = points[i][1] + (points[i - 1][0] - points[i - 1][1]).clamped(20)
		points[i][1] = to_global(position + Vector2(0, -i * offset))
		if points[i][0].distance_to(points[i][1]) > 6:
			points[i][0].linear_interpolate(points[i][1], .2)

	update()
	pass

func _draw():
	for p in points:
		draw_circle(to_local(p[0]), piece_size + 1, Color("161519"))
	for p in points:
		draw_circle(to_local(p[0]), piece_size, Color("cbdbfc"))

