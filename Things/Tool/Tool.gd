class_name Tool extends RigidBody2D

signal drag_started(tool: Tool)

@onready var pin_component: PinComponent = $PinComponent
@onready var tween: Tween
var _is_under_mouse := false
var _dragging := false
var _mouse_offset: Vector2

func _ready() -> void:
	if Engine.is_editor_hint(): return

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
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0, 0.05)
	drag_started.emit(self)
	_freeze.call_deferred()
	can_sleep = false
	_dragging = true
	_mouse_offset = global_position - get_global_mouse_position()

func end_drag() -> void:
	_unfreeze.call_deferred()

	_dragging = false
	can_sleep = true

	pin_component.try_pin()

func on_pinned(cushion: PinCushionComponent):
	_freeze.call_deferred()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_transform", cushion.global_transform, 0.1)

func on_unpinned(_cushion: PinCushionComponent):
	_unfreeze.call_deferred()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0, 0.1)

func _process(_delta: float) -> void:
	if not _dragging: return

	var mouse_position := get_global_mouse_position()
	position = mouse_position + _mouse_offset
	linear_velocity = Vector2.ZERO

func _on_mouse_entered() -> void:
	_is_under_mouse = true

func _on_mouse_exited() -> void:
	_is_under_mouse = false

func _freeze() -> void:
	freeze = true

func _unfreeze() -> void:
	freeze = false
