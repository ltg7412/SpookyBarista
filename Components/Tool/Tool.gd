class_name Tool extends RigidBody2D

signal drag_started(tool: Tool)

@onready var pin_component: PinComponent = $PinComponent
var _is_under_mouse := false
var _dragging := false
var _mouse_offset: Vector2
var coffee: Coffee

func _ready() -> void:
	add_to_group(&"tools")
	input_pickable = true
	pin_component.pinned.connect(on_pinned)
	pin_component.unpinned.connect(on_unpinned)

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton: return

	if event.is_action_pressed(&"interact"):
		attempt_interaction()
	if event.is_action_released(&"interact") and _dragging:
		Globals.release_tool()

func attempt_interaction() -> void:
	var mouse_over_tool = _is_under_mouse and not _dragging
	if not mouse_over_tool: return
	if Globals.is_dragging(): return

	if pin_component.is_pinned():
		pin_component.unpin()

	Globals.grab_tool(self)

func start_drag() -> void:
	drag_started.emit(self)
	can_sleep = false
	_dragging = true
	_mouse_offset = global_position - get_global_mouse_position()

func end_drag() -> void:
	_dragging = false
	can_sleep = true

	pin_component.try_pin()

func on_pinned(cushion: PinCushionComponent):
	freeze = true
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", cushion.global_position, 0.1)

func on_unpinned(cushion: PinCushionComponent):
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
