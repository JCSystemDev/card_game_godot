class_name Notifications extends Node2D
@onready var game: PackedScene = load("res://Scenes/game_zone.tscn")
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")
@onready var world: PackedScene = load("res://Scenes/world.tscn")
@onready var endgame_label: Label = $"Endgame Notification/Label"
@onready var win_buttons = $"Endgame Notification/Win Buttons"
@onready var lose_buttons = $"Endgame Notification/Lose Buttons"

func _on_exit_button_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(menu, "transition")

func _on_retry_button_pressed():
	AudioManager.play_sound("Equip.wav")
	Transition.reaload_scene("transition")

func _on_end_button_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(world, "transition")	
