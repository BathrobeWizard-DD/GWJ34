extends Node2D

export(int) var offset = 2
export(int) var piece_size = 4

var points = [
	[Vector2(0, 0), Vector2(0, 0)],
	[Vector2(0, -offset), Vector2(0, 0)],
	[Vector2(0, -offset), Vector2(0, 0)],
	[Vector2(0, -offset), Vector2(0, 0)],
	[Vector2(0, -offset), Vector2(0, 0)]
]

func _process(delta):
	for i in range(len(points) -1, -1, -1):
		if i == 0:
			points[i][1] = global_position
			continue
		points[i][1] = points[i][0] + points[i - 1][1]
	
	update()
	
func _draw():
	for p in points:
		draw_circle(to_local(p[1]), 3, Color("161519"))
	for p in points:
		draw_circle(to_local(p[1]), 2, Color("cbdbfc"))
