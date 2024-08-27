extends Node2D
var cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/cards.json"))
var deck_cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/deck.json"))
var enemies = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/enemies.json"))
var player_stats = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/player_stats.json"))
var enemies_list: Array = []
var deck_list: Array = []

func _ready():
	_get_enemies()
	_get_deck()
	

func _get_enemies():
	for enemy in enemies:
		enemies_list.append(enemy["enemy_name"])

func _get_deck():
	for card in deck_cards[0]["cards"]:
		deck_list.append(card)
