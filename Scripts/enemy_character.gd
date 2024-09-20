class_name EnemyCharacter extends Node2D

@export var enemy_name: String
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
var enemy_texture: Texture2D

func _ready():
	for enemy in DataManager.enemies:
		if enemy_name == enemy["enemy_name"]:
			enemy_texture = load(enemy["enemy_sprite"])

func _on_battle_area_body_entered(body):
	if body.is_in_group("player"):
		DataManager.enemy_summon = enemy_name
		Transition.load_scene(game_zone, "transition")
		AudioManager.play_sound("Summon.wav")
