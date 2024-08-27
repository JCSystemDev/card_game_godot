extends Node2D
var cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/cards.json"))
var deck_cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/deck.json"))
var enemies = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/enemies.json"))
var player_stats = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/player_stats.json"))

var enemies_list_low: Array = []
var enemies_list_mid: Array = []
var enemies_list_high: Array = []
var deck_list: Array = []

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
		
