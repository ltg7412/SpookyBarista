class_name Cup extends Tool

@export var _coffee: Coffee

func set_coffee(coffee: Coffee) -> void:
	self.coffee = coffee

func get_coffee() -> Coffee:
	return _coffee
