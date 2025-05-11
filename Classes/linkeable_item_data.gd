extends ItemData
class_name ItemDataLinkeable

var Linkin
var TubeInit

@export var structure: PackedScene

func right_use(player) -> bool:
	if player.raycast_3D.is_colliding() and player.collider.is_in_group("EntradaTubo"):
		if Linkin:
			var Building = structure.instantiate()
			Building.get_node("Path3D").curve.add_point(TubeInit[0],Vector3.ZERO,TubeInit[1]*3)
			Building.get_node("Path3D").curve.add_point(player.collider.global_position,player.normal_colision*3,Vector3.ZERO)
			player.get_parent().add_child(Building)
			Building.Extremos["Entrada"] = TubeInit[2]
			Building.Extremos["Salida"] = player.collider.get_parent().get_parent()
			Linkin = false
			return true
		else:
			TubeInit = [player.collider.global_position,player.normal_colision,player.collider.get_parent().get_parent()]
			Linkin = true
			return false
	else:
		return false
