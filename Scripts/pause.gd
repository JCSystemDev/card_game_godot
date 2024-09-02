extends Control
class_name Pause
@onready var player_name_label = $Player/Name
@onready var player_level_label = $Player/Level
@onready var player_attack_label = $Player/Attack
@onready var player_defense_label = $Player/Defense
@onready var player_hp_label = $Player/HP
@onready var resume_button: Button = $"Buttons/Resume Button"

func _ready():
	player_name_label.set_text(DataManager.player_stats[0]["player_name"])
	player_level_label.set_text(str("LV. ",DataManager.player_stats[0]["player_level"]))
	player_hp_label.set_text(str("HP ",DataManager.player_stats[0]["player_hp"],"/",DataManager.player_stats[0]["player_hp"]))
	player_attack_label.set_text(str("ATTACK ",DataManager.player_stats[0]["player_attack"]))
	player_defense_label.set_text(str("DEFENSE ",DataManager.player_stats[0]["player_defense"]))
		

func _on_exit_button_pressed():
	pass # Replace with function body.


func _on_load_button_pressed():
	pass # Replace with function body.


func _on_save_button_pressed():
	pass # Replace with function body.


func _on_resume_button_pressed():
	pass
	

func _on_options_button_pressed():
	pass # Replace with function body.
