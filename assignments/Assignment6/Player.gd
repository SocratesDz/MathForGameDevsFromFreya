extends KinematicBody

const WALK_SPEED = 2
const MOUSE_SENSITIVITY = 0.02

onready var lookPivot = $LookPivot
onready var gunRayCast = $LookPivot/GunRayCast
onready var laser = $LookPivot/Gun/Laser
onready var gun = $LookPivot/Gun

var movement = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	gunRayCast.force_raycast_update()
	var origin = gunRayCast.transform.xform(laser.transform.origin)
	var point = gunRayCast.cast_to
	var collider = gunRayCast.get_collider()
	if collider:
		point = laser.transform.xform_inv(gunRayCast.get_collision_point())
	
	laser.clear()
	laser.begin(Mesh.PRIMITIVE_LINES)
	_draw_collision_position_line(origin, point)
	if collider:
		var normal = gunRayCast.get_collision_normal()
		_draw_collision_normal_line(point, normal)
	laser.end()
	
	movement = move_and_slide(_get_movement_input() * WALK_SPEED, Vector3.UP)

func _input(event):
	if event is InputEventMouseMotion:
		var speed = event.relative * MOUSE_SENSITIVITY
		rotate_y(lerp(0, -speed.x, 0.5))
		lookPivot.rotate_x(lerp(0, speed.y, 0.5))
		
		var camera_rotation = lookPivot.rotation_degrees
		camera_rotation.x = clamp(camera_rotation.x, -75, 75)
		lookPivot.rotation_degrees = camera_rotation

func _get_movement_input():
	var z = Input.get_action_strength("forward") - Input.get_action_strength("backwards")
	var x = Input.get_action_strength("strafe_left") - Input.get_action_strength("strafe_right")
	return transform.basis.xform(Vector3(x, 0, z))

func _draw_collision_position_line(var origin: Vector3, var position: Vector3):
	laser.set_color(Color.white)
	laser.add_vertex(origin)
	laser.add_vertex(position)

func _draw_collision_normal_line(var origin: Vector3, var normal: Vector3):
	laser.set_color(Color.blue)
	laser.add_vertex(origin)
	laser.add_vertex(origin*normal)

func _draw_mesh_cube() -> MeshInstance:
	var corners = PoolVector3Array()
	# bottom 4 positions:
	corners.push_back(Vector3(1, 0, 1))
	corners.push_back(Vector3(-1, 0, 1))
	corners.push_back(Vector3(-1, 0, -1))
	corners.push_back(Vector3(1, 0, -1))
	# top 4 positions:
	corners.push_back(Vector3(1, 2, 1))
	corners.push_back(Vector3(-1, 2, 1))
	corners.push_back(Vector3(-1, 2, -1))
	corners.push_back(Vector3(1, 2, -1))
	
	var array_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = corners
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_LOOP, arrays)
	
	var mesh = MeshInstance.new()
	mesh.mesh = array_mesh
	return mesh
