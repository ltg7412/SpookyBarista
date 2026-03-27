@tool
extends InteractorTool

@onready var label_sprite: Sprite2D = $Label

@export var milk: Milk:
	set(value):
		milk = value
		_on_milk_set()

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	super(interaction_cushion)
	
	if interaction_cushion.cushion_owner is not Pitcher: return

	var pitcher := (interaction_cushion.cushion_owner as Pitcher)
	pitcher.set_milk(milk.copy())
	print("milk poured")

func _on_milk_set():
	if milk != null:
		$Label.texture = milk.label_texture

	if Engine.is_editor_hint():
			update_configuration_warnings()

func _get_configuration_warnings():
	if milk == null:
		return ["Milk is unset!"]
	return []
