class_name Milk extends Ingredient

@export var label_texture: Texture2D
@export var is_steamed: bool = false

func copy() -> Milk:
	var milk := Milk.new()
	milk.is_steamed = is_steamed
	milk.display_name = display_name
	milk.id = id
	return milk

func compare(milk: Milk) -> bool:
	if milk.id != id: return false
	if milk.is_steamed != is_steamed: return false

	return true
