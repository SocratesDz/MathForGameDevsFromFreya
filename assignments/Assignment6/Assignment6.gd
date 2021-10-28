extends Spatial

onready var camera = $Camera
onready var point = $Point

const RAY_LENGTH = 1000

var from_pointing = null
var to_pointing = null

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _physics_process(delta):
	if from_pointing and to_pointing:
		var space = get_world().direct_space_state
		var result = space.intersect_ray(from_pointing, to_pointing)
		if result:
			var pointPosition = result.position
			point.clear()
			point.begin(PrimitiveMesh.PRIMITIVE_POINTS)
			point.set_color(Color.green)
			point.add_vertex(pointPosition)
			point.end()


func _input(event):
	if event is InputEventMouseMotion:
		var from = camera.project_ray_origin(event.position)
		var to = camera.project_ray_normal(event.position) * RAY_LENGTH
		from_pointing = from
		to_pointing = to
