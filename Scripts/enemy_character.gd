class_name EnemyCharacter extends Node2D

@export var enemy_name: String
var sprite_frames: SpriteFrames = load("res://Animations/enemy_idle.tres")
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
var dialogue_start: String
var dialogue_challenge: String
var dialogue_negative: String
var enemy_texture: Texture2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: InteractionArea = $"Interaction Area"

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	var frame_0: Texture2D = load("res://Assets/Sprites/Enemies/"+enemy_name+" 0.png")
	var frame_1: Texture2D = load("res://Assets/Sprites/Enemies/"+enemy_name+" 1.png")
	var animation_name: String = enemy_name + "_idle"
	sprite_frames.add_animation(animation_name)
	sprite_frames.add_frame(animation_name, frame_0)
	sprite_frames.add_frame(animation_name, frame_1)
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play(animation_name)
	for enemy_dialogues in DataManager.dialogues:
		if enemy_name == enemy_dialogues["enemy_name"]:
			dialogue_start = enemy_dialogues["dialogue_start"]  
			dialogue_challenge = enemy_dialogues["dialogue_challenge"]
			dialogue_negative = enemy_dialogues["dialogue_negative"]
	
	for enemy in DataManager.enemies:
		if enemy_name == enemy["enemy_name"]:
			enemy_texture = load(enemy["enemy_sprite"])

func _on_interact():
	if DialogueManager.line_state == DialogueManager.line.start:
		DialogueManager._load_dialogue_box(dialogue_start, enemy_texture ,enemy_name)
	elif DialogueManager.line_state == DialogueManager.line.challenge:
		DialogueManager._load_dialogue_box(dialogue_challenge, enemy_texture, enemy_name)
	elif DialogueManager.line_state == DialogueManager.line.negative:
		DialogueManager._load_dialogue_box(dialogue_negative, enemy_texture, enemy_name)
	if DialogueManager.battle:
		DataManager.enemy_summon = enemy_name
		Transition.load_scene(game_zone, "transition")
		AudioManager.play_sound("Summon.wav")
