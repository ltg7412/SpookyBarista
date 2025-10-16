class_name PinCushionComponent extends Area2D

signal pinned_by(pin: PinComponent)
signal unpinned(pin: PinComponent)

var pinned_with: PinComponent

func try_pin_with(pin: PinComponent) -> bool:
	pinned_by.emit(pin)
	pinned_with = pin
	return true

func remove_pin() -> void:
	unpinned.emit(pinned_with)
	pinned_with = null
