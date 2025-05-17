extends CharacterBody3D

signal toggle_inventory()
signal use_slot()

var SPEED = 15
const JUMP_VELOCITY = 2
const SENSIBILITY = 0.005

@onready var HUD = $HUD
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var voxel_lod_terrain = $"../VoxelLodTerrain"
@onready var raycast_3D = $Head/Camera3D/RayCast3D
@onready var Conectando = false
@onready var TubeInit
@onready var VisibleCursor = false
@onready var target_pos
@onready var normal_colision
@onready var collider


@export var InventarioItems: InventoryData
@export var HotbarItems: InventoryData


func _ready() -> void:
	PlayerManager.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	

func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion and !VisibleCursor:
		#head.rotate_y(-event.relative.x * SENSIBILITY)
		#camera.rotate_x(-event.relative.y * SENSIBILITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(60))
	if Input.is_action_just_pressed("tab"):
		toggle_inventory.emit()



func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_released("interact"):
			Interact()
	
	if !VisibleCursor:
		if Input.is_action_pressed("jump"):
			velocity.y += JUMP_VELOCITY
		elif Input.is_action_pressed("sneak"):
			velocity.y -= JUMP_VELOCITY
		else:
			velocity.y = 0

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		#var input_dir = Input.get_vector("left", "right", "up", "down")
		#var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#if direction:
			#velocity.x = direction.x * SPEED
			#velocity.z = direction.z * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
			#velocity.z = move_toward(velocity.z, 0, SPEED)
			
		if Input.is_action_pressed("sprint"):
			SPEED = 25
		if Input.is_action_just_released("sprint"):
			SPEED = 10
		
		move_and_slide()
		
		#target_pos = raycast_3D.get_collision_point()
		#normal_colision = raycast_3D.get_collision_normal()
		#collider = raycast_3D.get_collider()
		#if not raycast_3D.is_colliding():
			#target_pos = raycast_3D.global_position-raycast_3D.global_basis.z*5

			
		if Input.is_action_just_pressed("right_click"):
			use_slot.emit()
			#if HUD.ActualItemPos == 0 and Contar_Qbits([0]) > 0:
				#voxel_tool.mode = VoxelTool.MODE_SET
				#voxel_tool.grow_sphere(target_pos,2,2)
				#Disminuir_Qbit([0],1)
			#elif HUD.ActualItemPos == 1:
				#var Building = ResourceLoader.load("res://Scenes/input.tscn").instantiate()
				#Building.position = target_pos
				#Building.rotation = normal_colision
				#voxel_lod_terrain.add_child(Building)
			#elif HUD.ActualItemPos == 2 and collider.is_in_group("EntradaTubo"):
				
			#elif HUD.ActualItemPos == 3 and collider.is_in_group("EntradaTubo"):
				#
				#if collider.get_parent().get_parent().is_in_group("Input") and Contar_Qbits([0]) >= 3:
					#Disminuir_Qbit([0],3)
					#collider.get_parent().get_parent().Agregar_Qbit([0],3)
				#elif collider.get_parent().get_parent().is_in_group("Output") and collider.get_parent().get_parent().Contar_Qbits([1]) >= 3:
					#Agregar_Qbit([1],3)
					#collider.get_parent().get_parent().Disminuir_Qbit([1],3)
				
		#if Input.is_action_pressed("left_click") and raycast_3D.is_colliding() and collider.is_in_group("Suelo"):
			#pass


func Interact() -> void:
	if raycast_3D.is_colliding() and raycast_3D.get_collider().is_in_group("InventarioExterno"):
		raycast_3D.get_collider().player_interact()
		
func get_drop_position() -> Vector3:
	var direction = -camera.global_transform.basis.z
	return camera.global_position + direction
