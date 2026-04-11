extends Node2D

@onready var sound: AudioStreamPlayer = $Sound

func _on_pin_cushion_component_pinned_by(pin: PinComponent) -> void:
	sound.play()
	pin.pinning.queue_free()
