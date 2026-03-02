class_name NpcManager extends Node2D

#TEMPORARY, REDESIGN
@export var customer_data: Array[NpcData]
@export var customer_line_path: Path2D
@export var npc_scene: PackedScene
var customers: Array[Npc]
var current_customer: Npc = null
var step_size: float
var scale_step_size: float

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
	if customers.size() < 1: return
	
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
	next_customer()
