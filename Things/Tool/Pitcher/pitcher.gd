class_name Pitcher extends InteractorTool

@export var milk: Milk

func _on_interaction_started(interaction_cushion: ToolInteractionCushion) -> void:
	#start animation
	pass

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	if interaction_cushion.cushion_owner is not Cup:
		printerr("Cup pitching is attempting to pour is not a cup")
		return
	if not has_milk():
		print("NO MILK IN PITCHER")
		return

	var cup := (interaction_cushion.cushion_owner as Cup)
	cup.get_coffee().milk = milk
	print("interaction completed")

func has_milk() -> bool:
	return milk != null
	#end animation
