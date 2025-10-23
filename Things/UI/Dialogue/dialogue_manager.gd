class_name DialogueManager extends Control

@onready var dialogue_display: DialogueDisplay = %DialogueDisplay
@onready var coffee_order_display: OrderDispaly = %CoffeeOrderDisplay

func _ready() -> void:
	Globals.dialogue_manager = self
	dialogue_display.dialogue_ended.connect(_on_dialogue_ended)
	hide()

func start_dialogue(dialogue_file_path: String, npc: Npc) -> void:
	show()

	var file = FileAccess.open(dialogue_file_path, FileAccess.READ)
	var json = JSON.new()
	var content = file.get_as_text()
	var error = json.parse(content)

	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
		return

	var dialogue_data = json.data
	if typeof(dialogue_data) != TYPE_DICTIONARY:
		print("Unexpected data")
		return

	dialogue_display.start_dialogue(dialogue_data, npc)
	coffee_order_display.show_order(npc.coffee_order)

func _on_dialogue_ended():
	hide()
