class_name Npc extends PathFollow2D

signal serve_complete(score: float)

@onready var sprite = $Sprite
@export var data: NpcData
var coffee_order: Coffee
var order_responses: Dictionary[float, String]


func _ready() -> void:
	reset_expression()
	coffee_order = Coffee.new()
	coffee_order.load_from_json(data.order_file_path)
	load_order_responses()

func load_order_responses() -> void:
	var file = FileAccess.open(data.order_file_path, FileAccess.READ)
	var json = JSON.new()
	var content = file.get_as_text()
	var error = json.parse(content)

	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
		return

	var response_data = json.data.get("responses")
	if typeof(response_data) != TYPE_DICTIONARY:
		print("Unexpected data")
		return

	for key_string in response_data.keys():
		var key: float = float(key_string)
		order_responses[key] = response_data.get(key_string)
	
	print(order_responses)


func start_dialogue() -> void:
	var dialogue_path = data.dialogue_file_path
	Globals.dialogue_manager.start_dialogue(dialogue_path, self)

func set_expression(id: String) -> void:
	var texture = data.expressions.get(id)
	sprite.texture = texture

func reset_expression() -> void:
	set_expression(data.default_expression_id)

func serve(coffee: Coffee) -> void:
	var score := coffee_order.compare(coffee)
	print(score)
	var response_string = order_responses.get(score)
	Globals.dialogue_manager.show_order_response(response_string, self)
	await Globals.dialogue_manager.dialogue_display.dialogue_ended
	serve_complete.emit(score)
