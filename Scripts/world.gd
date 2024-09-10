extends CanvasLayer

var transition: bool
var player_scene = load("res://Scenes/player_character.tscn")
@onready var spawn_point: Marker2D = $"Spawn Point"
@onready var pause_screen: Pause = $"Pause Screen"

func _ready():
	pause_screen.hide()
	pause_screen.parallax.hide()
	AudioManager.play_music("4 - Village.ogg")
	var player_character = player_scene.instantiate()
	add_child(player_character)
	player_character.global_position = spawn_point.position

func _input(event):
	if event.is_action_pressed("ui_cancel") && !Transition.in_transition && !DialogueManager.in_dialogue:
		swap_pause_state()


func swap_pause_state():
	AudioManager.play_sound("Discard.wav")
	
	if not pause_screen.visible:
		get_tree().paused = true
		Transition.play_transition("crossfade")
		await get_tree().create_timer(0.2).timeout
		pause_screen.visible = true
		pause_screen.parallax.show()
		
	elif pause_screen.visible:
		get_tree().paused = false
		Transition.play_transition("crossfade")
		await get_tree().create_timer(0.2).timeout
		pause_screen.visible = false
		pause_screen.parallax.hide()
		
		
		
		
