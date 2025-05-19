extends PanelContainer

@onready var quantity: Label = $Quantity
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var selection_rect: ColorRect = $SelectionRect


signal slot_clicked(index: int, button: int)

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	if item_data is ItemDataQBit:
		var prob_cero
		var prob_uno 
		prob_cero = floor(pow(abs(float(item_data.qbits[0])),2) * 100)
		prob_uno = floor(pow(abs(float(item_data.qbits[1])),2) * 100)

		item_data.description = 'Matriz: ' + str(prob_cero) + '% y ' + str(prob_uno) + '%' 
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity.visible = true
		quantity.text = "x%s" % slot_data.quantity
	else:
		quantity.visible = false
		
		
func Selected() -> void:
	selection_rect.visible = not selection_rect.visible

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
			
