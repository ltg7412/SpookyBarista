class_name NpcManager extends Node2D

#TEMPORARY, REDESIGN
@onready var npc: Npc = %Npc

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	npc.start_dialogue()
