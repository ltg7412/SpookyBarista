class_name OrderDispaly extends Control

@onready var circle = $Circle 
@onready var s_pos = $SmallPosition
@onready var m_pos = $MediumPosition
@onready var l_pos = $LargePosition

@onready var syrup_label = $SyrupLabel
@onready var shots_label = $ShotsLabel
@onready var milk_label = $MilkLabel

func show_order(coffee: Coffee) -> void:
	print(circle.position)
	match coffee.size:
		Coffee.CoffeeSize.SMALL:
			circle.position = s_pos.position
		Coffee.CoffeeSize.MEDIUM:
			circle.position = m_pos.position
		Coffee.CoffeeSize.LARGE:
			circle.position = l_pos.position
	print(circle.position)

	syrup_label.text = coffee.syrup.id
	shots_label.text = str(coffee.shot_count)
	milk_label.text = coffee.milk.id
