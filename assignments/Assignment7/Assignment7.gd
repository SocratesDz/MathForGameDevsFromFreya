extends Node2D

onready var shape_generator = $ShapeGenerator
onready var radius_indicator = $Control/Panel/VBoxContainer/HBoxContainer/RadiusIndicator
onready var points_indicator = $Control/Panel/VBoxContainer/HBoxContainer2/PointsIndicator

onready var depth_slider = $Control/Panel/VBoxContainer/HBoxContainer3/DepthSlider
onready var depth_indicator = $Control/Panel/VBoxContainer/HBoxContainer3/DepthIndicator


func _on_RadiusSlider_value_changed(value):
	shape_generator.radius = value
	radius_indicator.text = str(value)

func _on_PointsSlider_value_changed(value):
	shape_generator.points = value
	points_indicator.text = str(value)
	depth_slider.max_value = value-1

func _on_DepthSlider_value_changed(value):
	shape_generator.depth = value
	depth_indicator.text = str(value)
