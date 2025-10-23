class_name Coffee extends Resource

enum CoffeeSize { SMALL = 1, MEDIUM = 2, LARGE = 3}

@export var size: CoffeeSize = CoffeeSize.SMALL
@export var syrup: Syrup
@export_range(1, 3) var shot_count: int
@export var milk: Milk

const COFFEE_DATA_KEY = "order"
const SIZE_KEY = "size"
const SYRUP_ID_KEY = "syrup"
const SHOT_COUNT_KEY = "shotCount"
const MILK_TYPE_KEY = "milkType"

func has_syrup() -> bool:
	return syrup != null

func has_milk() -> bool:
	return milk != null

func copy() -> Coffee:
	var coffee := Coffee.new()
	coffee.size = size
	coffee.syrup = syrup
	coffee.shot_count = shot_count
	coffee.milk = milk.copy()
	return coffee

func compare(coffee: Coffee) -> float:
	var match_count: float = 0.0
	if coffee.size == size: match_count += 1.0
	if coffee.has_syrup() and coffee.syrup.id == syrup.id: match_count += 1.0
	if coffee.shot_count == shot_count: match_count += 1.0
	if coffee.has_milk() and coffee.milk.compare(milk): match_count += 1.0

	return match_count/4

func load_from_json(file_path: String) -> Coffee:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json = JSON.new()
	var content = file.get_as_text()
	var error = json.parse(content)

	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", content, " at line ", json.get_error_line())
		return null

	var coffee_data = json.data.get(COFFEE_DATA_KEY)
	if typeof(coffee_data) != TYPE_DICTIONARY:
		print("Unexpected data")
		return null

	syrup = Syrup.new()
	syrup.id = coffee_data.get(SYRUP_ID_KEY)
	milk = Milk.new()
	milk.id = coffee_data.get(MILK_TYPE_KEY)
	size = int(coffee_data.get(SIZE_KEY))
	shot_count = int(coffee_data.get(SHOT_COUNT_KEY))

	return self
