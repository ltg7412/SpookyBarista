extends Node2D

func _ready() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
	for child in get_children():
		_on_child_entered_tree(child)
	
func _on_child_entered_tree(child: Node) -> void:
	if child is not Tool: return
	(child as Tool).drag_started.connect(_on_tool_dragged)

func _on_tool_dragged(tool: Tool):
	move_child(tool, -1)
