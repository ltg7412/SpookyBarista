extends Node2D

var pitcher: Pitcher
var cup: Cup

func _on_steam_cushion_pinned_by(pin: PinComponent) -> void:
	pitcher = pin.pinning

func _on_steam_cushion_unpinned(_pin: PinComponent) -> void:
	pitcher = null

func _on_espresso_cushion_pinned_by(pin: PinComponent) -> void:
	cup = pin.pinning

func _on_espresso_cushion_unpinned(_pin: PinComponent) -> void:
	cup = null


func _on_brew_button_released() -> void:
	if cup == null: return
	cup.get_coffee().shot_count += 1
	print(cup.get_coffee().shot_count)

func _on_steam_button_released() -> void:
	if pitcher == null: return
	if not pitcher.has_milk(): return

	pitcher.milk.is_steamed = true
