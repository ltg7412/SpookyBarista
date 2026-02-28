class_name Tool extends RigidBody2D

signal drag_started(tool: Tool)

@onready var pin_component: PinComponent = $PinComponent
@onready var tween: Tween
var _is_under_mouse := false
var _dragging := false
var _mouse_offset: Vector2
var _rotation_offset: float

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

	Globals.grab_tool(self)

	if pin_component.is_pinned():
		pin_component.unpin()


func start_drag() -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0, 0.1)
	drag_started.emit(self)
	_freeze.call_deferred()
	can_sleep = false
	_dragging = true

	#var rotation_point = global_position - get_global_mouse_position()
	#var rotated_position = rotation_point.rotated(-global_rotation)
	#_mouse_offset = rotated_position
	_mouse_offset = global_position - get_global_mouse_position()
	_rotation_offset = rotation

func end_drag() -> void:
	_unfreeze.call_deferred()

	_dragging = false
	can_sleep = true

	pin_component.try_pin()

func on_pinned(cushion: PinCushionComponent):
	_freeze.call_deferred()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	var pin_transform := cushion.get_pin_transform()
	#tween.tween_property(self, "global_transform", pin_position, 0.1)
	tween.tween_property(self, "global_transform", pin_transform, 0.1)

func on_unpinned(_cushion: PinCushionComponent):
	_unfreeze.call_deferred()

	if _dragging: return

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0, 0.5)
	#rotation = 0

func _process(_delta: float) -> void:
	if not _dragging: return

	global_position = get_global_mouse_position()

	var mouse_position: Vector2 = get_global_mouse_position()

	var offset = _mouse_offset.rotated(rotation-_rotation_offset)

	position = mouse_position + offset

func _on_mouse_entered() -> void:
	_is_under_mouse = true

func _on_mouse_exited() -> void:
	_is_under_mouse = false

func _freeze() -> void:
	freeze = true

func _unfreeze() -> void:
	freeze = false
