extends ToolInteractionCushion

func try_pin_with(pin: PinComponent) -> bool:
	if pin.pinning is not Cup:
		return false
	if (pin.pinning as Cup).get_coffee().has_syrup():
		return false

	return super(pin)
