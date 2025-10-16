extends PinCushionComponent

@export var acceptable_pin_ids: Array[StringName]

func try_pin_with(pin: PinComponent) -> bool:
	if not acceptable_pin_ids.has(pin.id):
		return false
	
	super(pin)
	return true
