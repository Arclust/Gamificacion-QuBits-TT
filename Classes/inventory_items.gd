extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null
#
func select_slot_data(index: int) -> void:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		return
	print(slot_data)

func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	var return_slot_data: SlotData
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
	inventory_updated.emit(self)
	return return_slot_data

func use_slot_data(index: int) -> void:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		return
	if PlayerManager.use_slot_data(slot_data):
		reduce_slot_quantity(1,index)
	
	inventory_updated.emit(self)

func reduce_slot_quantity(cant, index) -> void:
	if slot_datas[index].quantity > 1:
		slot_datas[index].quantity -= cant
	else:
		slot_datas[index] = null

func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
	inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null

func pick_up_slot(slot_data: SlotData) -> bool:
	for index in slot_datas.size():
		if slot_datas[index] and slot_datas[index].can_fully_merge_with(slot_data):
			slot_datas[index].fully_merge_with(slot_data)
			inventory_updated.emit(self)
			return true
	for index in slot_datas.size():
		if not slot_datas[index]:
			slot_datas[index] = slot_data
			inventory_updated.emit(self)
			return true
	return false

func pipe_insert(insert_slot: SlotData) -> void:
	for index in slot_datas.size():
		var slot_data = slot_datas[index]
		if not slot_data:
			pass
		else:
			print(slot_data.can_merge_with(insert_slot))
			if slot_data.can_merge_with(insert_slot):
				slot_data.fully_merge_with(insert_slot) # Fusionar con el slot completo
				inventory_updated.emit(self)
				return
	for index in slot_datas.size():
		var slot_data = slot_datas[index]
		if not slot_data:
			slot_datas[index] = insert_slot # Insertar el slot completo si no hay merge
			inventory_updated.emit(self)
			return

func pipe_pick_up_first(name: String) -> SlotData:
	for index in slot_datas.size():
		if slot_datas[index] and slot_datas[index].item_data.name == name:
			var picked_slot = SlotData.new() # Crear un nuevo SlotData
			picked_slot.item_data = slot_datas[index].item_data.duplicate(true) as ItemDataQBit # Duplicar el ItemData
			picked_slot.quantity = 1 # Tomar solo uno para la tubería
			reduce_slot_quantity(1, index) # Reducir la cantidad en el inventario original
			inventory_updated.emit(self)
			return picked_slot
	return null


func on_slot_clicked(index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)
