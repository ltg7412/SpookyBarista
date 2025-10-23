class_name Clickable extends Area2D

signal pressed
signal released

func _ready() -> void:
	input_pickable = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		pressed.emit()
		return
	
	if event.is_action_released("interact"):
		released.emit()
		return
