extends Control

@onready var play_button: TextureButton = $PlayButton
@onready var guide_button: TextureButton = $GuideButton
@onready var menu_music: AudioStreamPlayer = $MenuMusic
@export var guide: Control
var game_scene = preload("res://game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	guide_button.pressed.connect(_on_guide_button_pressed)

func _on_play_button_pressed() -> void:
	#get_tree().change_scene_to_packed(game_scene)
	start_game()
	
func _on_guide_button_pressed() -> void:
	guide.show()

func start_game() -> void:
	hide()
	menu_music.playing = false
