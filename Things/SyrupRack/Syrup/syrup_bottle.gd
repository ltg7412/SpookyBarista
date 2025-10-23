@tool
class_name SyrupBottle extends Node2D

@export var syrup: Syrup:
	set(value):
		syrup = value
		_on_syrup_set()
@onready var label_sprite = $LabelSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_syrup_set():
	if Engine.is_editor_hint():
		update_configuration_warnings()

	$LabelSprite.texture = syrup.label_texture

func _get_configuration_warnings():
	if syrup == null:
		return ["Syrup is unset!"]
	return []

func _on_cup_cushion_pinned_by(_pin: PinComponent) -> void:
	animation_player.play("squirt")

func get_syrup() -> Syrup:
	return syrup
