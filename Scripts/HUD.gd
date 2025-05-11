extends Control

var ActualItemPos

func _ready() -> void:
	ActualItemPos = 0

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_1 and event.keycode <= KEY_9:
			var numero = event.keycode - KEY_0
			ActualItemPos = numero -1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		if ActualItemPos==8:
			ActualItemPos = 0
		else:
			ActualItemPos += 1
	elif Input.is_action_just_pressed("scroll_down"):
		if ActualItemPos==0:
			ActualItemPos = 8
		else:
			ActualItemPos -= 1
