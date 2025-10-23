extends Node

var syrup_resource_dir_path := "res://Resources/Syrups/"
var milk_resource_dir_path := "res://Resources/Milks/"

var syrups: Dictionary[String, Ingredient]
var milks: Dictionary[String, Ingredient]

func _ready() -> void:
	syrups = load_resources(syrup_resource_dir_path)
	milks = load_resources(milk_resource_dir_path)

func load_resources(dir_path: String) -> Dictionary[String, Ingredient]:
	var dict: Dictionary[String, Ingredient] = {}
	var dir := DirAccess.open(dir_path)
	if not dir:
		print("Could not load resources at " + dir_path)
		return {}
	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		var file_path := dir_path.path_join(file_name)
		var ingredient := load(file_path) as Ingredient
		dict.set(ingredient.id, ingredient)
		file_name = dir.get_next()
	dir.list_dir_end()
	return dict

func get_syrup(id: String) -> Syrup:
	return syrups.get(id) as Syrup

func get_milk(id: String) -> Milk:
	return milks.get(id) as Milk
