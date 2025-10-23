class_name Cup extends InteractorTool

@export var _coffee: Coffee
@export var full_cup_texture: Texture2D
@onready var sprite = $Sprite

func _ready() -> void:
	_coffee = Coffee.new()
	super()

func set_coffee(coffee: Coffee) -> void:
	_coffee = coffee

func get_coffee() -> Coffee:
	return _coffee

func add_shots(amount: int) -> void:
	_coffee.shot_count += amount
	if _coffee.shot_count > 0:
		sprite.texture = full_cup_texture

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	if _coffee.has_syrup(): return
	if interaction_cushion.cushion_owner is not SyrupBottle: return
	var syrup_bottle := interaction_cushion.cushion_owner as SyrupBottle
	_coffee.syrup = syrup_bottle.get_syrup()
