class_name Hand extends Node2D
@export var hand_radius: int = 100 
@export var card_angle: float = 90
@export var angle_limit: float = 25
@export var max_cards_spread_angle: float = 5
@onready var collision_shape: CollisionShape2D = $DebugShape2D
@onready var card_scene: PackedScene = preload("res://Scenes/card.tscn")
@onready var game_zone: GameZone = $".."


var hand_cards: Array = []
var touched_cards: Array = []
var current_selected_card_index: int = -1

func add_card(card: Node2D):
	hand_cards.push_back(card)
	add_child(card)
	card.mouse_entered.connect(_handle_card_touched)
	card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()

func use_card(index: int) -> Node2D:
	var using_card = hand_cards[index]
	if game_zone.player.current_gold >= using_card.card_cost:
		apply_card_effect(using_card)
		hand_cards.remove_at(index)
		touched_cards.remove_at(touched_cards.find(using_card))
		remove_child(using_card)
		reposition_cards()
		discard_card(using_card.card_name)
	else: 
		AudioManager.play_sound("Alert.wav")
	return using_card
	
func discard_card(_card_name: String):
	var card: Card = card_scene.instantiate()
	game_zone.discard_pile.discard_sprite.add_child(card)
	game_zone.discard_pile.discard_pile_cards.append(_card_name)
	card.card_name = game_zone.discard_pile.discard_pile_cards[-1]
	card._set_values(card.card_name)
	card.visible = true
	game_zone.discard_pile.quantity_discard_pile_cards = len(game_zone.discard_pile.discard_pile_cards)

func apply_card_effect(_card: Card):
	game_zone.player.current_gold -= _card.card_cost
	if _card.card_type == "HP":
		if _card.card_subtype == "+":
			AudioManager.play_sound("Magic.wav")
			game_zone.player.player_anim.play("player_magic")
			if game_zone.player.current_hp + _card.number_effect > game_zone.player.player_hp:
				game_zone.player.current_hp = game_zone.player.player_hp
				
			else:
				game_zone.player.current_hp += _card.number_effect
			if game_zone.player.current_attack > game_zone.player.player_hp:
				game_zone.player.current_hp = game_zone.player.player_hp
		else:
			game_zone.player.current_hp -= _card.number_effect
	elif _card.card_type == "Attack":
		if _card.card_subtype == "+":
			AudioManager.play_sound("Equip.wav")
			game_zone.player.current_attack += _card.number_effect
		else:
			game_zone.player.current_attack -= _card.number_effect
	elif _card.card_type == "Defense":
		if _card.card_subtype == "+":
			AudioManager.play_sound("Equip.wav")
			game_zone.player.current_defense += _card.number_effect
		else:
			game_zone.player.current_defense -= _card.number_effect
			
			
func reposition_cards():
	var card_spread = min(angle_limit / hand_cards.size(), max_cards_spread_angle)
	var current_angle = -(card_spread * (hand_cards.size() - 1))/2 - 90
	for card in hand_cards:
		_update_card_transform(card, current_angle)
		current_angle += card_spread
		

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(int(x), int(y))
	
func _update_card_transform(card: Node2D, angle_in_drag: float):
		card.set_position(get_card_position(angle_in_drag))
		card.set_rotation(deg_to_rad(angle_in_drag + 90))

func _handle_card_touched(card: Card):
	touched_cards.push_back(card)
		
func _handle_card_untouched(card: Card):
	touched_cards.remove_at(touched_cards.find(card))
	
func _input(event):
	if event.is_action_pressed("mouse_click") && current_selected_card_index >= 0: 	
		if game_zone.phase.current_phase == game_zone.phase.phase.attack:	
			var _card = use_card(current_selected_card_index)
			current_selected_card_index = -1	
		
func _process(_delta):	
	for card in hand_cards:
		current_selected_card_index = -1
		card.unhighlight()
	
	if !touched_cards.is_empty():
		var highest_touched_index: int = -1
		
		for card in touched_cards:
			highest_touched_index = max(highest_touched_index, hand_cards.find(card))
		
		if 	highest_touched_index >= 0 && highest_touched_index < hand_cards.size():
			hand_cards[highest_touched_index].highlight()
			current_selected_card_index = highest_touched_index
	
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
