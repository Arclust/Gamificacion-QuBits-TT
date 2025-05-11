extends Camera3D

@onready var gridmap


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		shoot_ray("R")
	if event.is_action_pressed("left_click"):
		shoot_ray("L")
	
func shoot_ray(action):
	var grid_map = get_tree().get_root().get_node("TestScene").get_node("GridMap")
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	if space.intersect_ray(ray_query):
		var raycast_result = space.intersect_ray(ray_query)
		var pos = grid_map.local_to_map(raycast_result.position)
		print(pos)
		if (action == "R"):
			grid_map.set_cell_item(pos, -1)
			pass
		if (action == "L"):
			#grid_map.set_cell_item(raycast_result.position, -1)
			pass
