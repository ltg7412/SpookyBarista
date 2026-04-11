extends Control

@onready var back_button = $BackButton
@onready var continue_button = $ContinueButton
@export var menu: Control

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	continue_button.pressed.connect(_on_continue_button_pressed)

func _on_back_button_pressed() -> void:
	hide()
	
func _on_continue_button_pressed() -> void:
	hide()
	menu.start_game()
