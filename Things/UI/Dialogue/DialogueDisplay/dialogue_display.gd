class_name DialogueDisplay extends Panel

signal dialogue_ended

@export var button_scene: PackedScene
@onready var button_container = %ButtonContainer
@onready var text_box = %TextBox
var passages
var npc: Npc
const PASSAGE_KEY = "passages"
const OPTIONS_KEY = "links"
const LINK_KEY = "link"
const STARTING_PASSAGE_KEY = "start"
const TEXT_KEY = "text"
const EXPRESSION_KEY = "execute"

func start_dialogue(dialogue_data: Dictionary, npc: Npc) -> void:
	self.npc = npc
	passages = dialogue_data[PASSAGE_KEY]
	var starting_passage_id: String = dialogue_data[STARTING_PASSAGE_KEY]
	show_passage(starting_passage_id)

func show_passage(id: String) -> void:
	npc.reset_expression()
	var passage: Dictionary = passages[id]
	var text = passage[TEXT_KEY]
	check_expression(passage)
	text_box.text = text
	var options = passage.get(OPTIONS_KEY)
	if options == null:
		end_dialogue()
		return
	for option in options:
		create_option(option)

func check_expression(passage: Dictionary) -> void:
	var expression_id = passage.get(EXPRESSION_KEY)
	if expression_id == null: return
	npc.set_expression(expression_id)

func create_option(option: Dictionary) -> void:
	var text = option[TEXT_KEY]
	var id = option[LINK_KEY]
	var button: DialogueButton = button_scene.instantiate()
	button.init(text)
	var on_option_chosen_func = _on_option_chosen.bind(id) if id != null else end_dialogue
	button.button_up.connect(on_option_chosen_func)
	button_container.add_child(button)

func remove_options() -> void:
	for option in button_container.get_children():
		option.queue_free()

func _on_option_chosen(id: String) -> void:
	remove_options()
	show_passage(id)

func end_dialogue() -> void:
	passages = null
	npc = null
	text_box.text = ""
	remove_options()
	dialogue_ended.emit()
