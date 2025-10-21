extends Node2D

func _process(_delta) -> void:
	if Input.is_action_just_pressed(&"test"):
		$NpcContainer/Npc.test()
