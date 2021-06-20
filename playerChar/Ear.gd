extends Node2D

export(int) var length = 10

onready var points := [
		[position, position],
		[position, position],
		[position, position],
		[position, position],
		[global_position, global_position],
]

onready var offset_angle := 0.0
onready var default_angle := Vector2.UP.angle()

func _physics_process(_delta):
	self.rotation_degrees = 0
	
	for i in range(len(points)):
		if i == 0:
			points[i][0] = points[i][1]
			points[i][1] = to_global(position + Vector2(0, -i * 2))
			continue
		points[i][0] = points[i][1] + (points[i - 1][0] - points[i - 1][1]).clamped(10)
		points[i][1] = to_global(position + Vector2(0, -i * 2))

	update()
	pass

func _draw():
#	# outline color
	draw_line(position, to_local(points.back()[0]), Color("363332"), 8)
	draw_circle(to_local(points.back()[0]), 5, Color("363332"))
#	# suit color
	draw_line(position, to_local(points.back()[0]), Color("cbdbfc"), 7)
	draw_circle(to_local(points.back()[0]), 4, Color("cbdbfc"))
#	# skin color
	draw_line(position, to_local(points.back()[0]), Color("f17bcc"), 3)

