extends Node

signal new_tool_grabbed(tool: Tool)

var dragging: Tool:
	set(value):
		dragging = value
		new_tool_grabbed.emit(dragging)

func grab_tool(tool: Tool) -> void:
	dragging = tool
	tool.start_drag()

func release_tool() -> void:
	dragging.end_drag()
	dragging = null
