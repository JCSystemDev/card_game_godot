extends Node2D

var player_scene = load("res://Scenes/player_character.tscn")
@onready var spawn_point : Marker2D = $"Spawn Point"

func _ready():
	AudioManager.play_music("World.mp3")
	var player_character = player_scene.instantiate()
	add_child(player_character)
	player_character.global_position = spawn_point.position

func _process(_delta):
	pass
