extends Node2D

# Data Base Access
var player_stats_default = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/player_stats_default.json"))
var cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/cards.json"))
var deck_cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/deck.json"))
var enemies = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/enemies.json"))
var dialogues = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/dialogues.json"))

# Basic Enemies Categories (Low Power / Mid Power / High Power)
var enemies_list_low: Array = []
var enemies_list_mid: Array = []
var enemies_list_high: Array = []

# Deck
var deck_list: Array = []

# Player Variables
var move_speed: float
var player_stats

# Enemy Varaibles
var enemy_summon: String

func _ready():
	_get_enemies()
	_get_deck()

func _get_enemies():
	for enemy in enemies:
		if enemy["enemy_level"] <= 4:
			enemies_list_low.append(enemy["enemy_name"])
		elif enemy["enemy_level"] <= 8:
			enemies_list_mid.append(enemy["enemy_name"])
		elif enemy["enemy_level"] <= 12:
			enemies_list_high.append(enemy["enemy_name"])

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
	var player_stats_load = JSON.parse_string(FileAccess.get_file_as_string("user://player_stats_saved.json"))
	player_stats = player_stats_load
