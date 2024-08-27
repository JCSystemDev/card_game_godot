class_name GameZone extends Node2D

@export var player: Player
@export var deck: Deck
@export var hand: Hand 
@export var phase: Phase
@export var discard_pile: Discard_Pile
@export var enemy: Enemy
@export var notifications: Notifications
var enemy_name: String = DataManager.enemies_list_low[randi() % DataManager.enemies_list_low.size()]
var deck_name: String = "deck.json"
var background_name: String = "res://Assets/Sprites/Backgrounds/Meadow.png"

func _ready():
	pass
