class_name SceneTransitionComponent extends Area2D

@export var camera: Camera2D
@export var offset: Vector2
@export var transition_speed: float = 0.35
var default_camera_position: Vector2


func _ready() -> void:
	default_camera_position = camera.position
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	var tween = get_tree().create_tween()
	#tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(
		camera,
		"position",
		default_camera_position + offset,
		transition_speed)

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	#tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(
		camera,
		"position",
		default_camera_position,
		transition_speed)
