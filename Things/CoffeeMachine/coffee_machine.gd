extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
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
	cup.can_grab = false
	#cup.lock()
	print(cup.get_coffee().shot_count)
	animation_player.play("brew")
	await animation_player.animation_finished
	#cup.unlock()
	cup.can_grab = true
	cup.add_shots(1) #TODO how many shots

func _on_steam_button_released() -> void:
	if pitcher == null: return
	if not pitcher.has_milk(): return
	#pitcher.lock()
	pitcher.can_grab = false
	animation_player.play("steam")
	await animation_player.animation_finished
	#pitcher.unlock()
	pitcher.can_grab = true
	pitcher.milk.is_steamed = true
