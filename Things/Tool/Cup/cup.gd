class_name Cup extends Tool

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
