class_name Npc extends Node2D

signal served(score: float)

@onready var sprite = $Sprite
@export var data: NpcData
var coffee_order: Coffee

func _ready() -> void:
	reset_expression()
	coffee_order = Coffee.new()
	coffee_order.load_from_json(data.order_file_path)

func start_dialogue() -> void:
	var dialogue_path = data.dialogue_file_path
	Globals.dialogue_manager.start_dialogue(dialogue_path, self)

func set_expression(id: String) -> void:
	var texture = data.expressions.get(id)
	sprite.texture = texture

func reset_expression() -> void:
	set_expression(data.default_expression_id)

func serve(coffee: Coffee) -> void:
	var score := coffee_order.compare(coffee)
	served.emit(score)
