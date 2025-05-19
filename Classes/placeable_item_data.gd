extends ItemData
class_name ItemDataPlaceable

@export var structure: PackedScene


#func right_use(player) -> bool:
	#if player.raycast_3D.is_colliding():
	#	var Building = structure.instantiate()
	#	print(player.target_pos)
	#	Building.position = player.target_pos
	#	print(player.normal_colision)
	#	Building.rotation = player.rotation
	#	player.get_parent().add_child(Building)
	#	return true
	#else:
	#	return false
