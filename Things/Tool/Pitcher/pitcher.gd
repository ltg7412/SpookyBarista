class_name Pitcher extends InteractorTool

@onready var sprite: Sprite2D = $Sprite
@export var empty_sprite: Texture2D
@export var full_sprite: Texture2D
@export var milk: Milk

func _on_interaction_started(interaction_cushion: ToolInteractionCushion) -> void:
	#start animation
	pass

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	super(interaction_cushion)

	if interaction_cushion.cushion_owner is not Cup:
		printerr("Cup pitching is attempting to pour is not a cup")
		return
	if not has_milk():
		print("NO MILK IN PITCHER")
		return

	var cup := (interaction_cushion.cushion_owner as Cup)
	cup.get_coffee().milk = milk
	empty_milk()

func has_milk() -> bool:
	return milk != null
	#end animation

func set_milk(new_milk: Milk) -> void:
	milk = new_milk
	if has_milk():
		sprite.texture = full_sprite

func empty_milk() -> void:
	milk = null
	sprite.texture = empty_sprite
