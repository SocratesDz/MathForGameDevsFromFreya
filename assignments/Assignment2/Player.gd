extends Sprite

export (NodePath) var targetPath = null
export (float, 0.0, 1.0) var threshold = 1.0

var target: Node2D = null
var detected = false
const line_length = 100

var line_end_vector = Vector2(line_length, 0)

func _ready():
	target = get_node(targetPath)

func _process(delta):
	look_at(get_global_mouse_position())
	var end_of_line = position + line_end_vector.rotated(global_rotation)
	if target:
		var target_direction = position.direction_to(target.position) # same as: (target.position - position).normalized()
		var pointing_direction = to_local(end_of_line).normalized().dot(to_local(target_direction))
		detected = pointing_direction >= threshold
		update()

func _draw():
	var line_color = Color.green if detected else Color.red
	draw_line(Vector2.ZERO, line_end_vector, line_color)


### Assignment 3
func _world_to_local(worldPos: Vector2) -> Vector2:
	#return transform.xform_inv(pos) # Uses inverse transform matrix to get pos
	var relativePoint = worldPos - global_position
	var x = relativePoint.dot(Vector2.RIGHT)
	var y = relativePoint.dot(Vector2.UP)
	return Vector2(x, y)
	
func _local_to_world(localPos: Vector2) -> Vector2:
	#return transform.xform(pos) # Uses transform matrix to get post 
	var offset = Vector2.RIGHT * localPos.x + Vector2.UP * localPos.y
	return global_transform.origin + offset
