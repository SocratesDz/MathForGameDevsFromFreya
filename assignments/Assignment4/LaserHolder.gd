extends Spatial

onready var laserEmitter := $LaserEmitter
onready var laserGunpoint := $LaserEmitter/LaserGunpoint
onready var laser := $Laser
onready var cameraHolder := $CameraHolder

const CAMERA_ROTATION = 0.03
const TURRET_ROTATION = 0.02
const LASER_LENGTH = 200.0

func _physics_process(_delta):
	_process_movement()
	_draw_laser()

func _process_movement():
	if Input.is_action_pressed("ui_left"):
		laserEmitter.rotate_y(TURRET_ROTATION)
	if Input.is_action_pressed("ui_right"):
		laserEmitter.rotate_y(-TURRET_ROTATION)
	if Input.is_action_pressed("ui_up"):
		laserEmitter.rotate_z(TURRET_ROTATION)
	if Input.is_action_pressed("ui_down"):
		laserEmitter.rotate_z(-TURRET_ROTATION)

func _draw_laser():
	var laserPointer = laserEmitter.transform.basis.xform(laserGunpoint.transform.origin)
	var points = _generate_laser_positions(laserPointer, get_world().direct_space_state, LASER_LENGTH)
	
	laser.clear()
	laser.begin(Mesh.PRIMITIVE_LINE_STRIP)
	for p in points:
		laser.add_vertex(p)
	laser.end()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var speed = event.relative.normalized()
		cameraHolder.rotate_y(CAMERA_ROTATION * speed.x)

func _generate_laser_positions(origin_pos: Vector3, direct_space_state: PhysicsDirectSpaceState, length: float) -> Array:
	var result = direct_space_state.intersect_ray(origin_pos, origin_pos * length)
	if result:
		var reflected = result.position - (2*result.normal.dot(result.position)*result.normal)
		var new_length = min(abs(result.position.distance_to(origin_pos)-length), length)
		return [origin_pos, result.position] + _generate_laser_positions(reflected, direct_space_state, new_length)
	else: return [origin_pos, origin_pos * length]
