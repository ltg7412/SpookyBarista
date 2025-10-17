class_name ToolInteractionCushion extends ConditionalPinCushion

signal interacted()

@export var interaction_length: int = 1
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = interaction_length
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func try_pin_with(pin: PinComponent) -> bool:
	if pin.pinning is not InteractorTool:
		return false

	return super(pin)

func _on_pin_pinned(pin: PinComponent) -> void:
	timer.start()

func _on_timer_timeout() -> void:
	if pinned_with == null: return

	interacted.emit()
	pinned_with.unpin()
