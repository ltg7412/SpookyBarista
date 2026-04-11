class_name NpcManager extends Node2D

#TEMPORARY, REDESIGN
@export var customer_data: Array[NpcData]
@export var customer_line_path: Path2D
@export var npc_scene: PackedScene
var customers: Array[Npc]
var current_customer: Npc = null
var step_size: float
var scale_step_size: float
var score := 0.0

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	initialize_customers()
	current_customer.start_dialogue()

func initialize_customers():
	step_size = 1.0/(customer_data.size()-1)
	scale_step_size = 0.5/(customer_data.size()-1)

	for i in range(customer_data.size()):
		var npc_data = customer_data[i]
		var npc: Npc = npc_scene.instantiate()
		npc.data = npc_data
		customers.append(npc)
		customer_line_path.add_child(npc);
		customer_line_path.move_child(npc, 0)
		npc.progress_ratio = step_size*i
		var npc_scale = 1 - scale_step_size*i
		npc.scale = Vector2(npc_scale, npc_scale)

	current_customer = customers[0]

func next_customer():
	#print("size: " + str(customers.size()))
	if customers.size() == 1:
		Globals.dialogue_manager.show_order_response("Your shift is over! You got " + str(score*4) + " out of 24 points. Thanks for playing the demo!", null)
		await Globals.dialogue_manager.dialogue_display.dialogue_ended
		get_tree().reload_current_scene()
	
	customers.remove_at(0)
	current_customer.queue_free()
	
	if customers.size() < 1: return
	
	current_customer = customers[0]

	var tween: Tween = get_tree().create_tween()
	tween.set_parallel()
	for customer in customers:
		tween.tween_property(
			customer,
			"progress_ratio",
			customer.progress_ratio-step_size,
			0.5)
		tween.tween_property(
			customer,
			"scale",
			customer.scale + Vector2(scale_step_size, scale_step_size),
			0.5)

	await tween.finished
	current_customer.start_dialogue()

func serve_coffee(coffee: Coffee):
	current_customer.serve(coffee)
	current_customer.serve_complete.connect(_on_serve_complete)

func _on_serve_complete(serve_score: float):
	score += serve_score
	next_customer()
