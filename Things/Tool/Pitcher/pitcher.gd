class_name Pitcher extends InteractorTool

@onready var sprite: Sprite2D = $Sprite
@export var empty_sprite: Texture2D
@export var full_sprite: Texture2D
@export var milk: Milk
@onready var steam_effect: CPUParticles2D = $SteamEffect
@onready var overlay_sprite: Sprite2D = $Overlay
#TODO: Make this better
func _process(_delta: float) -> void:
	super._process(_delta)
	
	if milk == null:
		return

	#print(milk.is_steamed)

	if milk.is_steamed:
		steam_effect.emitting = true
	else:
		steam_effect.emitting = false

func _on_interaction_started(_interaction_cushion: ToolInteractionCushion) -> void:
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
	cup.add_milk(milk)
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
	steam_effect.emitting = false

func _on_pin_component_pinned(_cushion: PinCushionComponent) -> void:
	overlay_sprite.z_index = 1

func _on_pin_component_unpinned(_cushion: PinCushionComponent) -> void:
	if overlay_sprite != null:
		overlay_sprite.z_index = 0
