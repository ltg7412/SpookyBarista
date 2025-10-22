class_name NpcData extends Resource

@export_file("*.json") var dialogue_file_path: String
@export_file("*.json") var order_file_path: String
@export var expressions: Dictionary[String, Texture2D]
@export var default_expression_id: String
