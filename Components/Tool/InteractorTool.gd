class_name InteractorTool extends Tool

func on_pinned(cushion: PinCushionComponent):
	super(cushion)
	
	if cushion is ToolInteractionCushion:
		_on_interaction_started(cushion)

func _on_interaction_started(interaction_cushion: ToolInteractionCushion) -> void:
	interaction_cushion.interacted.connect(_on_interaction_completed.bind(interaction_cushion))

func _on_interaction_completed(interaction_cushion: ToolInteractionCushion) -> void:
	pass

func on_unpinned(cushion: PinCushionComponent):
	cushion.interacted.disconnect(_on_interaction_completed)
	super(cushion)
