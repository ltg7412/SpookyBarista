extends Node2D

@export var guide: Control

func _on_help_button_pressed() -> void:
	guide.show_ingame()
