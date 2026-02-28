extends ConditionalPinCushion

var cup_offset := Vector2(0, -50)
var _cup_count: int = 0

func _on_pin_pinned(_pin: PinComponent) -> void:
	_cup_count += 1

func _on_pin_removed(_pin: PinComponent) -> void:
	_cup_count -= 1

func get_pin_transform() -> Transform2D:
	return global_transform.translated(cup_offset * _cup_count)
