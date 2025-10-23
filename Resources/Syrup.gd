class_name Syrup extends Ingredient

func copy() -> Syrup:
	var syrup = Syrup.new()
	syrup.id = id
	syrup.display_name = display_name
	return syrup
