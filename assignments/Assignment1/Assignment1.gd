extends Node2D

onready var target = $Target
onready var circle = $Circle

func _process(delta):
	#var distance = (target.position - circle.position).length()
	var distance = circle.position.distance_to(target.position)
	circle.detects = distance <= circle.radius

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		target.position = event.position
