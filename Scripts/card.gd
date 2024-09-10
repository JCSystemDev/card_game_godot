@tool
class_name Card extends Node2D
signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
@export var card_name: String 
var card_description: String
var card_cost: int
var card_sprite: Texture2D
var card_type: String
var number_effect: int
var card_target: String

@onready var cost_label: Label = $"Cost Display/Cost"
@onready var description_label: Label = $"Description Display/Description"
@onready var name_label: Label = $"Name Display/Card Name"
@onready var card_image: Sprite2D = $"Card Image/Card Avatar"
@onready var bg_sprite: Sprite2D = $"Front BG"

func _ready():
	_get_values(card_name)
	_set_values()
	visible = false
	
func _get_values(_card_name: String):
	for card in DataManager.cards:
		if card["card_name"] == _card_name:
			card_type = card["card_type"]
			card_target = card["card_target"]
			number_effect = card["number_effect"]
			card_description = card["card_type"] + " " + card["card_subtype"] + str(card["number_effect"])
			card_cost = card["card_cost"]
			card_sprite = load(card["card_sprite"])

func _set_values():
	cost_label.set_text(str(card_cost))
	description_label.set_text(card_description)
	name_label.set_text(card_name)
	card_image.set_texture(card_sprite)

func highlight():
	bg_sprite.set_modulate(Color(0.36, 0.5, 0.650))

func unhighlight():
	bg_sprite.set_modulate(Color(0.18, 0.25, 0.325))

func _on_area_2d_mouse_entered():
	mouse_entered.emit(self)

func _on_area_2d_mouse_exited():
	mouse_exited.emit(self)
