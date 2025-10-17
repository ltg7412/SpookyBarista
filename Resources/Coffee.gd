class_name Coffee extends Resource

enum CoffeeSize { SMALL, MEDIUM, LARGE }

@export var size: CoffeeSize
@export var syrup: Syrup
@export_range(1, 3) var shot_count: int
@export var milk: Milk
