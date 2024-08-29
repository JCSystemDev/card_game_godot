class_name EnemyCharacter extends Node2D

@export var enemy_name: String
var sprite_frames: SpriteFrames = load("res://Animations/enemy_idle.tres")
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn") 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	var frame_0: Texture2D = load("res://Assets/Sprites/Enemies/"+enemy_name+" 0.png")
	var frame_1: Texture2D = load("res://Assets/Sprites/Enemies/"+enemy_name+" 1.png")
	var animation_name: String = enemy_name + "_idle"
	sprite_frames.add_animation(animation_name)
	sprite_frames.add_frame(animation_name, frame_0)
	sprite_frames.add_frame(animation_name, frame_1)
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play(animation_name)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		DataManager.enemy_summon = enemy_name
		DataManager.move_speed = 0
		Transition.load_scene(game_zone, "transition")
		AudioManager.play_sound("Summon.wav")
