extends PanelContainer

signal hot_bar_use(index: int)

const Slot = preload("res://Scenes/slot.tscn")
var SelectedSlot = 0

@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var selection_rect: ColorRect = $SelectionRect

func _unhandled_key_input(event: InputEvent) -> void:
	if not visible or not event.is_pressed():
		return
	if range(KEY_1, KEY_9 + 1).has(event.keycode):
		h_box_container.get_children()[SelectedSlot].Selected()
		SelectedSlot = event.keycode - KEY_1
		h_box_container.get_children()[SelectedSlot].Selected()
		
func calling_use() -> void:
	hot_bar_use.emit(SelectedSlot)

func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_hot_bar)
	populate_hot_bar(inventory_data)
	h_box_container.get_children()[SelectedSlot].Selected()
	hot_bar_use.connect(inventory_data.use_slot_data)

func populate_hot_bar(inventory_data: InventoryData) -> void:
	for child in h_box_container.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas.slice(0,9):
		var slot = Slot.instantiate()
		h_box_container.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
