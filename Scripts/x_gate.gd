extends StaticBody3D

@export var inventory_data: InventoryData

func add_from_pipe(item_slot: SlotData) -> void:
	if item_slot.item_data is ItemDataQBit:
		for i in item_slot.item_data.qbits.size():
			item_slot.item_data.qbits[i] = not item_slot.item_data.qbits[i]
		inventory_data.pipe_insert(item_slot)
