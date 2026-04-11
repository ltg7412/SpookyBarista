extends Node2D

@onready var brew_animation: AnimationPlayer = $BrewAnimation
@onready var steam_animation: AnimationPlayer = $SteamAnimation
@onready var wand_layer: Sprite2D = $SteamWand
var pitcher: Pitcher
var cup: Cup

func _on_steam_cushion_pinned_by(pin: PinComponent) -> void:
	pitcher = pin.pinning
	wand_layer.z_index = 1

func _on_steam_cushion_unpinned(_pin: PinComponent) -> void:
	pitcher = null
	wand_layer.z_index = 0

func _on_espresso_cushion_pinned_by(pin: PinComponent) -> void:
	cup = pin.pinning

func _on_espresso_cushion_unpinned(_pin: PinComponent) -> void:
	cup = null
 

func _on_brew_button_released() -> void:
	if brew_animation.is_playing(): return
	if cup == null: return
	cup.can_grab = false
	#cup.lock()
	print(cup.get_coffee().shot_count)
	brew_animation.play("brew")
	await brew_animation.animation_finished
	#cup.unlock()
	cup.can_grab = true
	cup.add_shots(1) #TODO how many shots

func _on_steam_button_released() -> void:
	if steam_animation.is_playing(): return
	if pitcher == null: return
	if not pitcher.has_milk(): return
	#pitcher.lock()
	pitcher.can_grab = false
	steam_animation.play("steam")
	await steam_animation.animation_finished
	#pitcher.unlock()
	pitcher.can_grab = true
	pitcher.milk.is_steamed = true
