extends Node

signal new_tool_grabbed(tool: Tool)

var _dragging: Tool:
	set(value):
		_dragging = value
		new_tool_grabbed.emit(_dragging)

func grab_tool(tool: Tool) -> void:
	_dragging = tool
	tool.start_drag()

func release_tool() -> void:
	_dragging.end_drag()
	_dragging = null

func is_dragging() -> bool:
	return _dragging != null
