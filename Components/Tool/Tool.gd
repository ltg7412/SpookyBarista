class_name Tool extends RigidBody2D

@onready var pin_component = $PinComponent
var _is_under_mouse := false
var _dragging := false
var _mouse_offset: Vector2

func _ready() -> void:
	add_to_group(&"tools")
	input_pickable = true

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton: return

	if event.is_action_pressed(&"interact"):
		attempt_interaction()
	if event.is_action_released(&"interact") and _dragging:
		Globals.release_tool()

func attempt_interaction() -> void:
	if not _is_under_mouse or _dragging: return

	if pin_component.is_pinned():
		unpin()
		pin_component.unpin()

	Globals.grab_tool(self)

func start_drag() -> void:
	can_sleep = false
	_dragging = true
	_mouse_offset = global_position - get_global_mouse_position()

func end_drag() -> void:
	_dragging = false
	can_sleep = true
	
	var pin_cushion: PinCushionComponent = pin_component.try_pin()
	if pin_cushion != null:
		pin_to(pin_cushion)

func pin_to(cushion: PinCushionComponent):
	global_position = cushion.global_position #TWEEN THIS LATER
	freeze = true

func unpin():
	freeze = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not _dragging: return
	
	var mouse_position := get_global_mouse_position()
	state.transform.origin = mouse_position + _mouse_offset
	linear_velocity = Vector2.ZERO

func _on_mouse_entered() -> void:
	_is_under_mouse = true

func _on_mouse_exited() -> void:
	_is_under_mouse = false
