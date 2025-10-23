class_name InteractorTool extends Tool

func on_pinned(cushion: PinCushionComponent):
	super(cushion)
	
	if cushion is ToolInteractionCushion:
		cushion.interacted.connect(_on_interaction_completed.bind(cushion))
		_on_interaction_started(cushion)

func _on_interaction_started(_interaction_cushion: ToolInteractionCushion) -> void:
	pass

func _on_interaction_completed(_interaction_cushion: ToolInteractionCushion) -> void:
	pass

func on_unpinned(cushion: PinCushionComponent):
	if cushion is ToolInteractionCushion: 
		cushion.interacted.disconnect(_on_interaction_completed)
	super(cushion)
