extends Spatial

const ray_length = 1000

onready var camera = $Camera
onready var measureDisplay = $MeasureDisplay 

var pointing_position_origin = null
var pointing_position_destination = null

func _physics_process(delta):
	if pointing_position_origin and pointing_position_destination:
		var space = get_world().direct_space_state
		var result = space.intersect_ray(pointing_position_origin, pointing_position_destination)
		if result:
			var object = result.collider
			if object is StaticBody:
				if object.has_node("./MeshInstance"):
					var meshInstance = object.get_node("./MeshInstance")
					measureDisplay.objectName = object.name
					measureDisplay.meshPath = meshInstance.get_path()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == 1:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * ray_length
		pointing_position_origin = from
		pointing_position_destination = to
