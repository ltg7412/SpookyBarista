class_name InteractorTool extends Tool

var can_grab: bool = true

func attempt_interaction() -> void:
	if not can_grab: return
	super()

func on_pinned(cushion: PinCushionComponent):
	super(cushion)
	
	if cushion is ToolInteractionCushion:
		cushion.interacted.connect(_on_interaction_completed.bind(cushion))
		_on_interaction_started(cushion)

func _on_interaction_started(_interaction_cushion: ToolInteractionCushion) -> void:
	can_grab = false

func _on_interaction_completed(_interaction_cushion: ToolInteractionCushion) -> void:
	can_grab = true

func on_unpinned(cushion: PinCushionComponent):
	if cushion is ToolInteractionCushion: 
		cushion.interacted.disconnect(_on_interaction_completed)
	super(cushion)
