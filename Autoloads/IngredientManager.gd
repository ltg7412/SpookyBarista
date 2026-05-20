extends Node

var syrups: Dictionary[String, Ingredient]
var milks: Dictionary[String, Ingredient]

func _ready() -> void:
	syrups.set("blood", preload("res://Resources/Syrups/blood.tres"))
	syrups.set("butter_pecan", preload("res://Resources/Syrups/butter_pecan.tres"))
	syrups.set("caramel", preload("res://Resources/Syrups/caramel.tres"))
	syrups.set("cerebrospinal_fluid", preload("res://Resources/Syrups/cerebrospinal_fluid.tres"))
	syrups.set("marshmallow", preload("res://Resources/Syrups/marshmallow.tres"))
	syrups.set("meat", preload("res://Resources/Syrups/meat.tres"))

	milks.set("2%", preload("res://Resources/Milks/2%.tres"))
	milks.set("oat", preload("res://Resources/Milks/oat.tres"))
	milks.set("whole", preload("res://Resources/Milks/whole_milk.tres"))

func get_syrup(id: String) -> Syrup:
	return syrups.get(id) as Syrup

func get_milk(id: String) -> Milk:
	return milks.get(id) as Milk
