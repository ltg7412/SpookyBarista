class_name PinCushionComponent extends Area2D

signal pinned_by(pin: PinComponent)
signal unpinned(pin: PinComponent)

var pinned_with: PinComponent

func pin_with(pin: PinComponent) -> void:
	pinned_by.emit(pin)
	pinned_with = pin

func remove_pin() -> void:
	unpinned.emit(pinned_with)
	pinned_with = null
