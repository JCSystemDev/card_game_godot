class_name Player extends Node2D
var current_hp: int
var current_attack: int
var current_defense: int
var current_gold: int

@onready var player_portrait: Sprite2D = $"Stats Display/Portrait"
@onready var player_hp_label: Label = $"Stats Display/HP/HP Label"
@onready var player_hp_bar: ProgressBar = $"Stats Display/HP/Health Bar/Player HP"
@onready var player_attack_label: Label = $"Stats Display/Attack/Attack Label"
@onready var player_defense_label: Label = $"Stats Display/Defense/Defense Label"
@onready var player_gold_label: Label = $"Stats Display/Gold/Gold Label"
@onready var stats_display: Node2D = $"Stats Display"
@onready var player_anim: AnimationPlayer = $"Stats Display/AnimationPlayer"
@onready var game_zone: GameZone = $".."

func _get_values(): 
	current_gold = 0
	current_hp = DataManager.player_stats[0]["player_hp"]
	current_attack = DataManager.player_stats[0]["player_attack"]
	current_defense = DataManager.player_stats[0]["player_defense"]

func _set_values():
	player_portrait.set_texture(DataManager.player_portrait)
	player_hp_label.set_text(str("HP: ",current_hp,"/", DataManager.player_stats[0]["player_hp"] ))
	player_hp_bar.set_max(float(DataManager.player_stats[0]["player_hp"]))
	player_hp_bar.set_value(float(current_hp))
	player_attack_label.set_text(str(current_attack))
	player_defense_label.set_text(str(current_defense))
	player_gold_label.set_text(str(current_gold))

func _ready():
	_get_values()
	_set_values()

func _process(_delta):
	_set_values()
