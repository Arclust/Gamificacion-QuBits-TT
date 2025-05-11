extends Node3D

@onready var Extremos = {"Entrada": null, "Salida": null}
@onready var Desocupado
@onready var dataType
@export var inventory_data: InventoryData
@onready var path_follow_3d: PathFollow3D = $Path3D/PathFollow3D
@onready var timer: Timer = $Timer
@onready var item

func _ready() -> void:
	Desocupado = true

func _process(delta: float) -> void:
	if Desocupado:
		item = Extremos["Entrada"].inventory_data.pipe_pick_up_first("Qbit")
		if item:
			path_follow_3d.move_sprite()
			Desocupado = false
			path_follow_3d.set_sprites(item.item_data.texture)
			timer.start()

func _on_timer_timeout() -> void:
	Extremos["Salida"].add_from_pipe(item)
	path_follow_3d.move_sprite()
	path_follow_3d.set_sprites(null)
	Desocupado = true
	timer.stop()
	
