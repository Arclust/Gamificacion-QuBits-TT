extends PathFollow3D

@onready var sprite_3d_1: Sprite3D = $Sprite3D1
@onready var sprite_3d_2: Sprite3D = $Sprite3D2
@onready var active: bool = false
var tween

func set_sprites(sprite) -> void:
	sprite_3d_1.texture = sprite
	sprite_3d_2.texture  = sprite

func move_sprite():
	if tween:
		tween.kill() # Abort the previous animation.
		progress_ratio = 0
	tween = create_tween()
	tween.tween_property(self,"progress_ratio", 1.0, 2).set_trans(Tween.TRANS_LINEAR)
