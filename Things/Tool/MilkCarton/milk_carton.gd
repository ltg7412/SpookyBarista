@tool
extends InteractorTool

@onready var label_sprite: Sprite2D = $Label
@onready var pouring_sprite: Sprite2D = $PouringSprite
@onready var pouring_sound: AudioStreamPlayer = $PouringSound
@onready var sprite: Sprite2D = $Sprite
@export var milk: Milk:
	set(value):
		milk = value
		_on_milk_set()

var carton_closed_texture: Texture2D = preload("res://Things/Tool/MilkCarton/milk_carton.png")
var carton_open_texture: Texture2D = preload("res://Things/Tool/MilkCarton/Milk_Open.png")

func _on_interaction_started(_interaction_cushion: ToolInteractionCushion) -> void:
	super(_interaction_cushion)
	#TODO: Don't hard code this
	sprite.texture = carton_open_texture
	await get_tree().create_timer(0.1).timeout
	pouring_sound.play()
	pouring_sprite.show()

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	super(interaction_cushion)
	
	pouring_sprite.hide()
	sprite.texture = carton_closed_texture
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


func _on_pin_component_pinned(cushion: PinCushionComponent) -> void:
	pass # Replace with function body.

func _on_pin_component_unpinned(cushion: PinCushionComponent) -> void:
	pass # Replace with function body.
