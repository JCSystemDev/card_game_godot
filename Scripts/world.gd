extends Node2D

var transition: bool
var player_scene = load("res://Scenes/player_character.tscn")
@onready var spawn_point: Marker2D = $"Spawn Point"
@onready var pause_screen: Pause = $"Pause Screen"

func _ready():
	pause_screen.hide()
	AudioManager.play_music("World.mp3")
	var player_character = player_scene.instantiate()
	add_child(player_character)
	player_character.global_position = spawn_point.position

func _input(event):
	if event.is_action_pressed("ui_cancel") && !Transition.in_transition:
		swap_pause_state()


func swap_pause_state():
	if not pause_screen.visible:
		get_tree().paused = true
		Transition.play_transition("transition 2")
		Transition.play_backwards_transition("transition 2")
		pause_screen.show()
		
	elif pause_screen.visible:
		Transition.play_transition("transition 2")
		Transition.play_backwards_transition("transition 2")
		pause_screen.hide()
		get_tree().paused = false
