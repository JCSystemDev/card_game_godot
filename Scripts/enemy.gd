class_name Enemy extends Node2D
var enemy_hp: int
var enemy_background: String
var current_hp: int
var current_attack: int
var current_defense: int

@onready var game_zone : GameZone = $".."
@onready var name_enemy_label : Label = $"Enemy Name"
@onready var sprite_enemy : Sprite2D = $"Enemy Sprite"
@onready var flash_enemy : Sprite2D = $"Flash"
@onready var hp_enemy : ProgressBar = $"Enemy Bar/Enemy HP"
@onready var enemy_animation: AnimationPlayer = $AnimationPlayer

func _get_values(_enemy_name: String):
	for enemy in DataManager.enemies:
		if enemy["enemy_name"] == _enemy_name:
			name_enemy_label.set_text(enemy["enemy_name"])
			current_hp = enemy["enemy_hp"]
			current_attack = enemy["enemy_attack"]
			current_defense = enemy["enemy_defense"]
			sprite_enemy.set_texture(load(enemy["enemy_sprite"]))
			flash_enemy.set_texture(load(enemy["enemy_sprite"]))
			enemy_background = enemy["enemy_background"]
			hp_enemy.set_max(enemy["enemy_hp"])
			hp_enemy.set_value(current_hp)

func _update_values(_hp):
	hp_enemy.set_value(_hp)
	
func _ready():
	enemy_animation.play("RESET")
	_get_values(game_zone.enemy_name)

func _process(_delta):
	_update_values(current_hp)
