extends Node2D

export (int) var points := 3
export (int) var radius := 50
export (int) var depth := 1

func _process(delta):
	update()

func _draw():
	_draw_shape()

func _draw_shape():
	assert(points > 2)
	var points_array = PoolVector2Array()
	for i in range(points+1):
		var t = i / float(points)
		var angle = t * TAU
		var x = cos(angle)
		var y = sin(angle)
		var point := Vector2(x, y) * radius
		points_array.push_back(point)
		
	for i in range(points_array.size()):
		var index = i % (points_array.size()-1)
		var next_index = (i+depth) % (points_array.size()-1)
		draw_line(points_array[index], points_array[next_index], Color.red, 2.0, true)
