extends StaticBody3D

@export var inventory_data: InventoryData

func add_from_pipe(item_slot: SlotData) -> void:
	if item_slot.item_data is ItemDataQBit:
		var nuevo1 = str((1*int(item_slot.item_data.qbits[0]))+(0*int(item_slot.item_data.qbits[1])))
		var nuevo2 =str((0*int(item_slot.item_data.qbits[0]))+(-1*int(item_slot.item_data.qbits[1])))
		item_slot.item_data.qbits[0] = nuevo1
		item_slot.item_data.qbits[1] = nuevo2
		inventory_data.pipe_insert(item_slot)
