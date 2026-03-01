extends Node2D

var coffee_cup: Cup
@onready var serve_button = $ServeButton/ServeButtonSprite
@export var npc_manager: NpcManager

func _ready() -> void:
	serve_button.hide()

func _on_serve_cushion_pinned_by(pin: PinComponent) -> void:
	coffee_cup = pin.pinning
	serve_button.show()

func _on_serve_cushion_unpinned(_pin: PinComponent) -> void:
	coffee_cup = null
	serve_button.hide()

func _on_serve_button_released() -> void:
	if coffee_cup == null: return

	_on_coffee_served()

func _on_coffee_served():
	npc_manager.serve_coffee(coffee_cup.get_coffee())
