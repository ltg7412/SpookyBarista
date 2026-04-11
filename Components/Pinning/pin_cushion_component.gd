class_name PinCushionComponent extends Area2D

signal pinned_by(pin: PinComponent)
signal unpinned(pin: PinComponent)

@export var cushion_owner: Node
@export var one_pin_max := true
@export var silent := false
var pinned_with: PinComponent

func try_pin_with(pin: PinComponent) -> bool:
	if one_pin_max and pinned_with != null: return false
	pinned_by.emit(pin)
	pinned_with = pin
	_on_pin_pinned(pin)
	return true

func get_pin_transform() -> Transform2D:
	return global_transform

func remove_pin() -> void:
	_on_pin_removed(pinned_with)
	unpinned.emit(pinned_with)
	pinned_with = null

func _on_pin_pinned(_pin: PinComponent) -> void:
	pass

func _on_pin_removed(_pin: PinComponent) -> void:
	pass
