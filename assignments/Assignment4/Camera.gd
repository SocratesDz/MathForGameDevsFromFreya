extends Camera

onready var laserEmitter = $"../LaserEmitter"

var angle_speed = 0.1

func _process(delta):
	look_at(laserEmitter.transform.origin, Vector3.UP)
	global_transform.origin = laserEmitter.transform.origin

func _unhandled_input(event):
	if(event is InputEventMouseMotion):
		var direction = event.relative.normalized()
#		var distance = (laserEmitter.transform.origin - transform.origin).rotated(Vector3.UP, angle_speed*direction.x)
#		transform.origin = laserEmitter.transform.origin + distance
		rotate_y(angle_speed*direction.x)
