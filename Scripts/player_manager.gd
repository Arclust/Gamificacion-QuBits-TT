extends Node

var player

func use_slot_data(slot_data: SlotData) -> bool:
	return slot_data.item_data.right_use(player)
