extends CSGCylinder

onready var raycast := $RayCast
onready var laser := $Laser
onready var box1 := $"../CSGBox"
onready var cameraHolder := $CameraHolder

func _ready():
	print(transform.origin)
	print(box1.transform.origin)

func _process(delta):
	var collision_point = raycast.get_collision_point()
	laser.clear()
	laser.begin(Mesh.PRIMITIVE_LINE_STRIP)
	laser.add_vertex(transform.origin)
	laser.add_vertex(collision_point)
	laser.end()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var speed = event.relative.normalized()
		cameraHolder.rotate_y(PI/32 * speed.x)
