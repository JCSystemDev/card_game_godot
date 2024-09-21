extends Node2D
class_name Data

# Data Base Access
var cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/cards.json"))
var deck_cards = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/deck.json"))
var enemies = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/enemies.json"))
var npcs = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/npcs.json"))

# Deck
var deck_list: Array = []

# Player Variables
var in_battle: bool
var move_speed: float
var player_sprite: Texture2D
var player_portrait: Texture2D
var player_position_x: float
var player_position_y: float
var player_stats
var player_stats_load
var player_stats_default = [{
	
	"player_name": "",
	"player_level": 1,
	"player_hp": 20,
	"player_attack": 10,
	"player_defense": 3,
	"player_gold": 6,
	"player_exp": 0,
	"player_position_x": 480,
	"player_position_y": 416,
	"player_sprite":"",
	"player_portrait":"" 
	}]

# Enemy Variables
var enemy_summon: String
var enemies_list: Array

func _ready():
	_get_deck("deck_lv1")

# Build Deck
func _get_deck(lv_deck: String):
	for card in deck_cards[0][lv_deck]:
		deck_list.append(card)

# Build Enemy List
func _get_enemies(zone: String):
	enemies_list = []
	for enemy in enemies:
		if enemy["enemy_zone"] == zone:
			enemies_list.append(enemy["enemy_name"])
		
func _get_player_texture(player_texture: String, portrait_texture: String):
	player_stats_default[0]["player_sprite"] = player_texture
	player_stats_default[0]["player_portrait"] = portrait_texture
	player_sprite = load(player_stats_default[0]["player_sprite"])
	player_portrait = load(player_stats_default[0]["player_portrait"])

func _new_game():
	player_stats = player_stats_default

func _save_game():
	player_stats[0]["player_position_x"] = player_position_x
	player_stats[0]["player_position_y"] = player_position_y
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
