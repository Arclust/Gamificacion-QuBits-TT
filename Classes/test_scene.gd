extends Node

const PickUp = preload("res://Scenes/pick_up.tscn")

@onready var player: CharacterBody3D = $player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hot_bar_inventory: PanelContainer = $UI/HotBarInventory
var xr_interface: XRInterface

func _ready():
	
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.InventarioItems)
	hot_bar_inventory.set_inventory_data(player.InventarioItems)
	
	for node in get_tree().get_nodes_in_group("InventarioExterno"):
		node.toggle_inventory.connect(toggle_inventory_interface)
	for node in get_tree().get_nodes_in_group("Player"):
		node.use_slot.connect(use_item)

func use_item() -> void:
	hot_bar_inventory.calling_use()

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	player.VisibleCursor = not player.VisibleCursor
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		hot_bar_inventory.hide()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hot_bar_inventory.show()
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()

func _on_inventory_interface_drop_slot_data(slot_data: SlotData) -> void:
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = player.get_drop_position()
	add_child(pick_up)


func _on_child_entered_tree(node: Node) -> void:
	if node.is_in_group("InventarioExterno"):
		node.toggle_inventory.connect(toggle_inventory_interface)
