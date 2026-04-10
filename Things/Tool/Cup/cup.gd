class_name Cup extends InteractorTool

var _coffee: Coffee
@export var size: Coffee.CoffeeSize = Coffee.CoffeeSize.MEDIUM
@export var full_cup_texture: Texture2D
@export var is_stacked := false
@onready var sprite = $Sprite
@onready var steam_effect: CPUParticles2D = $SteamEffect
@onready var overlay_sprite: Sprite2D = $Overlay
var overlay_empty_texture = preload("res://Things/Tool/Cup/cutCoffeeEmptyBottom.png")
var overlay_full_texture = preload("res://Things/Tool/Cup/cutCoffeeFilledBottom.png")

func _ready() -> void:
	_coffee = Coffee.new()
	_coffee.size = size
	super()

# TODO: make this more efficient please
func _process(_delta: float) -> void:
	super._process(_delta)
	
	if _coffee == null: return

	if _coffee.shot_count > 0 or _coffee.milk != null and _coffee.milk.is_steamed:
		steam_effect.emitting = true
	else:
		steam_effect.emitting = false

func set_coffee(coffee: Coffee) -> void:
	_coffee = coffee

func get_coffee() -> Coffee:
	return _coffee

func add_milk(milk: Milk) -> void:
	_coffee.milk = milk

func add_shots(amount: int) -> void:
	_coffee.shot_count += amount
	if _coffee.shot_count > 0:
		sprite.texture = full_cup_texture
		overlay_sprite.texture = overlay_full_texture

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	super(interaction_cushion)
	if _coffee.has_syrup(): return
	if interaction_cushion.cushion_owner is not SyrupBottle: return
	var syrup_bottle := interaction_cushion.cushion_owner as SyrupBottle
	_coffee.syrup = syrup_bottle.get_syrup()


func _on_pin_component_pinned(_cushion: PinCushionComponent) -> void:
	overlay_sprite.z_index = 1

func _on_pin_component_unpinned(_cushion: PinCushionComponent) -> void:
	if overlay_sprite != null:
		overlay_sprite.z_index = 0
