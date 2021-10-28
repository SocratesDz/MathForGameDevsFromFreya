extends Node2D

export(bool) var detects := false
const radius := 100.0
var _color = Color.green

func _process(delta):
	_color = Color.red if detects else Color.green
	update()

func _draw():
	draw_circle_arc(Vector2.ZERO, radius, 0, 360, _color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
