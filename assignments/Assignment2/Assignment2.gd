extends Node2D

var end_position = Vector2.ZERO
const line_length = 100

onready var player := $Player
onready var target := $Target

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		end_position = (player.position + event.position).normalized() * line_length
		update()

func _draw():
	draw_line(player.position, end_position, Color.red)
