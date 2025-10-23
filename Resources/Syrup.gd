class_name Syrup extends Ingredient

@export var label_texture: Texture2D

func get_letter() -> String:
	return display_name.substr(0, 1)

#func copy() -> Syrup:
	#var syrup = Syrup.new()
	#syrup.id = id
	#syrup.display_name = display_name
	#return syrup
