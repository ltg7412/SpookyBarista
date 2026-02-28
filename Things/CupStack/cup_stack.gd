class_name CupStack extends Node2D

@export var cup_offset: int = 50
@onready var cup_cushion = $CupCushion

func _ready() -> void:
	cup_cushion.cup_offset = Vector2(0, -cup_offset)
