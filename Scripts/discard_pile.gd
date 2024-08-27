class_name Discard_Pile extends Node2D

@onready var game_zone: GameZone = $".."
@onready var cards_in_pile: Label = $"Discard Pile Label"
@onready var discard_sprite: Sprite2D = $"Discard Pile Sprite"

var discard_pile_cards: Array = []
var quantity_discard_pile_cards: int = 0

func _ready():
	cards_in_pile.set_text("P: "+str(quantity_discard_pile_cards))
	
func _process(_delta):
	cards_in_pile.set_text("P: "+str(quantity_discard_pile_cards))
