class_name PinComponent extends Area2D

@export var pinning: Node2D
var pinning_to: PinCushionComponent

func try_pin() -> PinCushionComponent:
	for area in get_overlapping_areas():
		if area is PinCushionComponent:
			pinning_to = area
			return area
	return null

func is_pinned() -> bool:
	return pinning_to != null

func unpin() -> void:
	pinning_to.remove_pin()
	pinning_to = null
