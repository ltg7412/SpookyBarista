class_name CupStack extends Node2D

@export var initial_cup_count: int = 8
@export var cup_offset: int = 50
@export var cup_scene: PackedScene
@export var tool_container: ToolContainer
@onready var cup_cushion = $CupCushion

func _ready() -> void:
	cup_cushion.cup_offset = Vector2(0, -cup_offset)
	create_cups(initial_cup_count)


func create_cups(count: int) -> void:
	for i in range(count):
		var cup: Cup = cup_scene.instantiate()
		cup.ready.connect(
			func():
				cup.pin_component.force_pin(cup_cushion)
		)
		tool_container.add_child(cup)
		
