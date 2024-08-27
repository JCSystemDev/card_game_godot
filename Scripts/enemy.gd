class_name Enemy extends Node2D
var enemy_name: String
var enemy_hp: int
var enemy_attack: int
var enemy_defense: int
var enemy_sprite: Texture2D
var enemy_flash: Texture2D
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
			enemy_hp = enemy["enemy_hp"]
			enemy_attack = enemy["enemy_attack"]
			enemy_defense = enemy["enemy_defense"]
			enemy_sprite = load(enemy["enemy_sprite"])
			enemy_flash = load(enemy["enemy_sprite"])
			
	current_hp = enemy_hp
	current_attack = enemy_attack
	current_defense = enemy_defense
	name_enemy_label.set_text(enemy_name)
	sprite_enemy.set_texture(enemy_sprite)
	flash_enemy.set_texture(enemy_sprite)
	hp_enemy.set_max(enemy_hp)
	hp_enemy.set_value(current_hp)

func _update_values(_hp):
	hp_enemy.set_value(_hp)
	
func _ready():
	enemy_animation.play("RESET")
	enemy_name = game_zone.enemy_name
	_get_values(enemy_name)

func _process(_delta):
	_update_values(current_hp)
