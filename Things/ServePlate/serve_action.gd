extends Node2D

var coffee_cup: Cup
@onready var serve_button = $ServeButton/ServeButtonSprite
@onready var npc: Npc = %Npc

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

	npc.serve(coffee_cup.get_coffee())
