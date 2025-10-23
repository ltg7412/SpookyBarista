@tool
class_name SyrupBottle extends Node2D

@export var syrup: Syrup:
	set(value):
		syrup = value
		_on_syrup_set()
@onready var label_sprite = $LabelSprite

func _on_syrup_set():
	if Engine.is_editor_hint():
		update_configuration_warnings()
	
	label_sprite.texture = syrup.label_texture

func _get_configuration_warnings():
	if syrup == null:
		return ["Syrup is unset!"]
	return []
