extends Node2D

onready var objects = $Objects
onready var camera = $Camera2D

func _process(delta):
	var max_position = camera.position
	var max_distance = 0
	for c in objects.get_children():
		var distance = camera.position.distance_to(c.position)
		max_distance = max(distance, max_distance)
		if max_distance == distance:
			max_position = camera.transform.xform(c.position)
	var camera_rect = camera.get_viewport_rect()
	var camera_length = camera.position.distance_to(camera_rect.end)
	var scale_factor = max_distance-camera_length
	camera.scale = Vector2(scale_factor, scale_factor)
