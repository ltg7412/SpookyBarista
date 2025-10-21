class_name Npc extends Node2D

@onready var sprite = $Sprite
@export var data: NpcData

func _ready() -> void:
	reset_expression()

func _start_dialogue() -> void:
	var dialogue_path = data.dialogue_file_path
	Globals.dialogue_manager.start_dialogue(dialogue_path, self)

func set_expression(id: String) -> void:
	var texture = data.expressions.get(id)
	sprite.texture = texture

func reset_expression() -> void:
	set_expression(data.default_expression_id)

func test(): # TODO: REMOVE THIS FUNC
	_start_dialogue()
