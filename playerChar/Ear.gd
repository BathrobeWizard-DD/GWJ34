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

# each point has a target_position(origin) and current_position
#onready var points := [
#	[position + Vector2(0, - offset * 0), position],
#	[position + Vector2(0, - offset * 1), position],
#	[position + Vector2(0, - offset * 2), position],
#	[position + Vector2(0, - offset * 3), position],
#	[position + Vector2(0, - offset * 4), position],
#]

#var point = {"old_global": Vector2.ZERO, "new_global": Vector2.ZERO}

func _process(_delta):
	for i in range(len(points)):
		if i == 0:
			points[i][0] = points[i][1]
			points[i][1] = to_global(position + Vector2(0, -i * offset))
			continue
		points[i][0] = points[i][1] + (points[i - 1][0] - points[i - 1][1])
		points[i][1] = to_global(position + Vector2(0, -i * offset))
		if points[i][0].distance_to(points[i][1]) > 6:
			points[i][0].linear_interpolate(points[i][1], .2)
			print("BIG")
#	point = prev_point
#	prev_point = global_position
#	var delta_pos = point - prev_point
#	point2 = prev_point2 + delta_pos
#	prev_point2 = to_global(position + Vector2(0, -2))
	
#	for i in range(len(points)-1, -1, -1):
#
#		var new_pos = to_global(position + Vector2(0, - offset * i))	
#		var old_pos = points[i][1]
#		var delta_pos = new_pos - old_pos
#
#		var new_prev_pos = to_global(position + Vector2(0, - offset * (i - 1)))	
#		var old_prev_pos = points[i - 1][1]
#		var delta_prev_pos = new_prev_pos - old_prev_pos
#
##		print(delta_prev_pos, delta_pos, new_prev_pos, old_prev_pos)
#		if old_pos != new_pos:
##			print("CHANGED", old_pos, new_pos)
#			points[i][1] = new_pos
#
##		point["new_global"] = to_global(position + Vector2(0, -2)) 
##		if point["old_global"] != point["new_global"]:
##			var delta_pos = point["new_global"] - point["old_global"]
###			print(delta_pos, point["new_global"])
##			point["old_global"] = point["new_global"]
#
##		print(get_global_offset(i).length())
#		if get_global_offset(i).length() <= offset:
##			points[i][1] = get_global_offset(i - 1)
##			points[i][1] = points[i][1].linear_interpolate(points[i-1][0], .1)
#			pass
##		points[i][1] = points[i][0] + points[i - 1][1]
##		points[i][1] = to_local(get_global_target_position(i))
##	print(get_global_target_position(1), get_global_offset(1))
	update()
	pass

func _draw():
	for p in points:
		draw_circle(to_local(p[0]), piece_size + 1, Color("161519"))
	for p in points:
		draw_circle(to_local(p[0]), piece_size, Color("cbdbfc"))
#	draw_circle(to_local(point2), piece_size + 1, Color("161519"))
#	draw_circle(to_local(point2), piece_size, Color("cbdbfc"))
	draw_circle(position, 2, Color("ff0000"))
#	for p in points:
#		draw_circle(to_local(point), piece_size + 1, Color("161519"))
#	for p in points:
#		draw_circle(to_local(point), piece_size, Color("cbdbfc"))
#
#func get_global_offset(idx: int) -> Vector2:
#	return  get_global_target_position(idx) - get_global_current_position(idx)
#
#func get_global_target_position(idx: int) -> Vector2:
#	return to_global(points[idx][0])
#
#func get_global_current_position(idx: int) -> Vector2:
#	return to_global(points[idx][1])
