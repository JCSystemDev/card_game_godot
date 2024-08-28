class_name GameZone extends Node2D

@export var player: Player
@export var deck: Deck
@export var hand: Hand 
@export var phase: Phase
@export var discard_pile: Discard_Pile
@export var enemy: Enemy
@export var notifications: Notifications
var enemy_name: String = DataManager.enemy_summon
var deck_name: String = "deck.json"
