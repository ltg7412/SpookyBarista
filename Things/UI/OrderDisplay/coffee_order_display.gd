class_name OrderDispaly extends Control

@onready var circle = $Card/Circle 
@onready var s_pos = $Card/SmallPosition
@onready var m_pos = $Card/MediumPosition
@onready var l_pos = $Card/LargePosition

@onready var syrup_label = $Card/SyrupLabel
@onready var shots_label = $Card/ShotsLabel
@onready var milk_label = $Card/MilkLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_area = $HoverArea

func show_order(coffee: Coffee) -> void:
	show()
	load_order(coffee)

func load_order(coffee: Coffee):
	match coffee.size:
		Coffee.CoffeeSize.SMALL:
			circle.position = s_pos.position
		Coffee.CoffeeSize.MEDIUM:
			circle.position = m_pos.position
		Coffee.CoffeeSize.LARGE:
			circle.position = l_pos.position

	syrup_label.text = coffee.syrup.get_letter()
	shots_label.text = str(coffee.shot_count)
	milk_label.text = coffee.milk.display_name

func end_dialogue():
	animation_player.play("DialogueEnded")

func _on_hover_area_mouse_entered() -> void:
	animation_player.play("Show")

func _on_hover_area_mouse_exited() -> void:
	animation_player.play_backwards("Show")
