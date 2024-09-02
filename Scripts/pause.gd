extends Control
class_name Pause
var text
@onready var game: Pause = $"."
@onready var player_name_label = $Player/Name
@onready var player_level_label = $Player/Level
@onready var player_attack_label = $Player/Attack
@onready var player_defense_label = $Player/Defense
@onready var player_hp_label = $Player/HP

func _ready():
	game.visible = false
	player_name_label.set_text(DataManager.player_stats[0]["player_name"])
	player_level_label.set_text(str("LV. ",DataManager.player_stats[0]["player_level"]))
	player_hp_label.set_text(str("HP ",DataManager.player_stats[0]["player_hp"],"/",DataManager.player_stats[0]["player_hp"]))
	player_attack_label.set_text(str("ATTACK ",DataManager.player_stats[0]["player_attack"]))
	player_defense_label.set_text(str("DEFENSE ",DataManager.player_stats[0]["player_defense"]))

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if game.visible == false:
			Transition.play_transition("transition 2")
			game.visible = true
			Transition.play_backwards_transition("transition 2")
			
		else:
			Transition.play_transition("transition 2")
			game.visible = false
			Transition.play_backwards_transition("transition 2")
