extends ToolInteractionCushion

func try_pin_with(pin: PinComponent) -> bool:
	if pin.pinning is not Pitcher:
		return false
	if not (pin.pinning as Pitcher).has_milk():
		return false

	return super(pin)
