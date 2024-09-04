extends Node2D

# Data Base Access
var cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/cards.json"))
var deck_cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/deck.json"))
var enemies = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/enemies.json"))
var dialogues = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/dialogues.json"))

# Deck
var deck_list: Array = []

# Player Variables
var move_speed: float
var player_stats
var player_stats_load
var player_stats_default = [{
	
	"player_name": "BENJAMIN",
	"player_level": 1,
	"player_hp" : 20,
	"player_attack" : 10,
	"player_defense" : 5,
	"player_gold" : 5,
	"player_exp" : 0}]

# Enemy Varaibles
var enemy_summon: String

func _ready():
	_get_deck()

func _get_deck():
	for card in deck_cards[0]["cards"]:
		deck_list.append(card)

func _new_game():
	player_stats = player_stats_default

func _save_game():
	player_stats = JSON.stringify(player_stats)
	var saved_file = FileAccess.open("user://player_stats_saved.json", FileAccess.WRITE)
	saved_file.store_string(player_stats)
	saved_file.close()

func _load_game():
	player_stats_load = JSON.parse_string(FileAccess.get_file_as_string("user://player_stats_saved.json"))
	player_stats = player_stats_load
	
func _save_file_exist():
	player_stats_load = FileAccess.get_file_as_string("user://player_stats_saved.json")
	if player_stats_load.is_empty():
		return false
	else:
		return true
