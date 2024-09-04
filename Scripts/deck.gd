class_name Deck extends Node2D

@onready var card_scene: PackedScene = preload("res://Scenes/card.tscn")
@onready var game_zone: GameZone = $".."
@onready var cards_in_deck: Label = $"Deck Cards"
var deck_cards: Array = []
var quantity_deck_cards: int
var path: String

func _ready():
	_get_cards()
	_shuffle_deck()
	quantity_deck_cards = len(deck_cards)
	cards_in_deck.set_text("D: "+str(quantity_deck_cards))

func _get_cards():
	for card in DataManager.deck_cards[0]["cards"]:
		deck_cards.append(card)
		
func _shuffle_deck():
	deck_cards.shuffle()

func _process(_delta):
	cards_in_deck.set_text("D: "+str(quantity_deck_cards))

func _draw_card():
	var card: Card = card_scene.instantiate()
	game_zone.hand.add_card(card)
	card.card_name = deck_cards[-1]
	card._get_values(card.card_name)
	card._set_values()
	card.visible = true
	deck_cards.pop_back()
	quantity_deck_cards = len(deck_cards)

func _full_hand():
	while len(game_zone.hand.hand_cards) < game_zone.hand.max_cards_spread_angle:
		if quantity_deck_cards >= 1:
			_draw_card()
			AudioManager.play_sound("Draw Phase.wav")
			await get_tree().create_timer(0.25).timeout
