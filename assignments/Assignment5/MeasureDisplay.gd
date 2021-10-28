extends Control

export (NodePath) var meshPath = null
export (String) var objectName = null

onready var objectNameLabel = $Panel/VSplitContainer/ObjectName
onready var surfaceAreaLabel = $Panel/VSplitContainer/SurfaceArea

func _process(delta):
	if meshPath:
		var meshInstance = get_node_or_null(meshPath)
		if meshInstance is MeshInstance:
			var triangles = meshInstance.mesh.get_faces()
			var areas = _calculate_triangles_areas(triangles)
			var totalMeshArea = _get_total_area(areas)
			objectNameLabel.text = objectName
			surfaceAreaLabel.text = "Total surface area: %.1fm^2" % totalMeshArea

func _get_total_area(triangleAreas: Array) -> float:
	var totalArea = 0.0
	for a in triangleAreas: totalArea += a
	return totalArea

func _calculate_triangles_areas(triangles: PoolVector3Array) -> Array:
	var areas = []
	for i in range(0, triangles.size(), 3):
		var three_vertex = []
		for j in range(3):
			three_vertex.append(triangles[i+j])
		areas.append(_calculate_single_triangle_area(three_vertex[0], three_vertex[1], three_vertex[2]))
	return areas

func _calculate_single_triangle_area(v1: Vector3, v2: Vector3, v3: Vector3) -> float:
	var a = v1.distance_to(v2)
	var b = v2.distance_to(v3)
	var c = v3.distance_to(v1)
	var semi_perimeter = (a+b+c)/2
	return sqrt(semi_perimeter*(semi_perimeter-a)*(semi_perimeter-b)*(semi_perimeter-c))
