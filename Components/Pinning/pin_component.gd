class_name PinComponent extends Area2D

signal pinned(cushion: PinCushionComponent)
signal unpinned(cushion: PinCushionComponent)

@export var pinning: Node2D
@export var id: StringName

var pinning_to: PinCushionComponent

func try_pin() -> bool:
	for area in get_overlapping_areas():
		if area is PinCushionComponent:
			if _try_pin_to_cushion(area): return true
	return false

func _try_pin_to_cushion(cushion: PinCushionComponent) -> bool:
	if not cushion.try_pin_with(self): return false
	pinning_to = cushion
	pinned.emit(cushion)
	return true

func is_pinned() -> bool:
	return pinning_to != null

func unpin() -> void:
	pinning_to.remove_pin()
	unpinned.emit(pinning_to)
	pinning_to = null
