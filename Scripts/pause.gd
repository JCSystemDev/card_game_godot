extends Control
class_name Pause
@onready var menu: PackedScene = load("res://Scenes/menu.tscn")
@export var world: Node2D
@onready var player_name_label: Label = $Player/Name
@onready var player_level_label: Label = $Player/Level
@onready var player_attack_label: Label = $Player/Attack
@onready var player_defense_label: Label = $Player/Defense
@onready var player_hp_label: Label = $Player/HP
@onready var player_exp_label: Label = $"Player/Exp"
@onready var resume_button: Button = $"Buttons/Resume Button"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var message_label: Label = $"Text Box/Message"

func _ready():
	player_name_label.set_text(DataManager.player_stats[0]["player_name"])
	player_level_label.set_text(str("LV. ",DataManager.player_stats[0]["player_level"]))
	player_hp_label.set_text(str("HP ",DataManager.player_stats[0]["player_hp"],"/",DataManager.player_stats[0]["player_hp"]))
	player_attack_label.set_text(str("ATK ",DataManager.player_stats[0]["player_attack"]))
	player_defense_label.set_text(str("DEF ",DataManager.player_stats[0]["player_defense"]))
	player_exp_label.set_text(str("EXP ",DataManager.player_stats[0]["player_exp"]))

func _on_exit_button_pressed():
	get_tree().paused = false
	AudioManager.play_sound("Discard.wav")
	Transition.load_scene(menu, "transition")

func _on_save_button_pressed():
	message_label.set_text("GAME SAVED")
	animation_player.play("show_text_box")
	AudioManager.play_sound("Equip.wav")
	DataManager._save_game()

func _on_resume_button_pressed():
	world.swap_pause_state()

func _on_options_button_pressed():
	pass
