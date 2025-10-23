@tool
extends InteractorTool

@export var milk: Milk:
	set(value):
		milk = value
		if Engine.is_editor_hint():
			update_configuration_warnings()

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	if interaction_cushion.cushion_owner is not Pitcher: return

	var pitcher := (interaction_cushion.cushion_owner as Pitcher)
	pitcher.milk = milk.copy()
	print("milk poured")

@export var set_me := 0:
	set(value):
		set_me = value
		if Engine.is_editor_hint():
			update_configuration_warnings()

func _get_configuration_warnings():
	if milk == null:
		return ["Milk is unset!"]
	return []
