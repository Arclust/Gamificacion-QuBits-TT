extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

func player_interact() -> void:
	toggle_inventory.emit(self)

func add_from_pipe(item_slot: SlotData) -> void:
	inventory_data.pipe_insert(item_slot)
