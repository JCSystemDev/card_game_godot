class_name NPCCharacter extends Node2D

@export var npc_name: String
var sprite_frames: SpriteFrames = load("res://Animations/npc_idle.tres")
var game_zone: PackedScene = load("res://Scenes/game_zone.tscn")
var dialogue_start: String
var dialogue_question: String
var dialogue_answer: String
var npc_texture: Texture2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: InteractionArea = $"Interaction Area"

func _ready():
	if npc_name == "Statue":
		interaction_area.action_name = "SAVE"
	interaction_area.interact = Callable(self, "_on_interact")
	var frame_1: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"1.png")
	var frame_2: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"5.png")
	var frame_3: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"9.png")
	var frame_4: Texture2D = load("res://Assets/Sprites/NPCs/"+npc_name+"13.png")
	var animation_name: String = npc_name + "_idle"
	sprite_frames.add_animation(animation_name)
	sprite_frames.add_frame(animation_name, frame_1)
	sprite_frames.add_frame(animation_name, frame_2)
	sprite_frames.add_frame(animation_name, frame_3)
	sprite_frames.add_frame(animation_name, frame_4)
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.play(animation_name)
	for npc in DataManager.npcs:
		if npc_name == npc["npc_name"]: 
			if npc_name == "Statue":
				dialogue_question = npc["dialogue"]
			else:
				dialogue_start = npc["dialogue"]	
	for npc in DataManager.npcs:
		if npc_name == npc["npc_name"]:
			npc_texture = load(npc["npc_sprite"])

func _on_interact():
	if npc_name == "Statue":
		DialogueManager._load_dialogue_box(dialogue_question, npc_texture ,npc_name)
		DialogueManager._play_dialogue_box()
		DialogueManager.yes_button.show()
		DialogueManager.no_button.show()
	else:
		DialogueManager._load_dialogue_box(dialogue_start, npc_texture ,npc_name)
		DialogueManager._play_dialogue_box()
