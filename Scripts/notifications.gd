class_name Notifications extends Node2D
@onready var game: PackedScene = load("res://Scenes/game_zone.tscn")
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")
@onready var endgame_label: Label = $"Endgame Notification/Label"
@onready var retry_button: Button = $"Endgame Notification/Buttons/Retry Button"

func _ready():
	retry_button.grab_focus()
	
func _on_exit_button_pressed():
	Transition.load_scene(menu)

func _on_retry_button_pressed():
	Transition.reaload_scene()
