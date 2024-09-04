extends Control

@onready var game: PackedScene = load("res://Scenes/world.tscn")
@onready var new_game: Button = $"Buttons/New Game"
@onready var load_game: Button = $"Buttons/Continue Game"
@onready var quit_game: Button = $"Buttons/Quit Game"

func _ready():
	Transition.animation_player.play_backwards("transition")
	AudioManager.play_music("Main Menu.mp3")
	new_game.grab_focus()
	if !DataManager._save_file_exist():
		load_game.set_disabled(true)
	
func parallax_bg(delta_time) -> void:
	get_node("ParallaxBackground").scroll_base_offset -= Vector2(1, 0) * 100 * delta_time	

func _process(delta):
	parallax_bg(delta)

func _on_quit_game_pressed():
	AudioManager.play_sound("Discard.wav")
	Transition.quit_transition("transition")
	quit_game.set_disabled(true)
	
func _on_new_game_pressed():
	DataManager._new_game()
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(game, "transition")
	new_game.set_disabled(true)

func _on_continue_game_pressed():
	DataManager._load_game()
	AudioManager.play_sound("Equip.wav")
	Transition.load_scene(game, "transition")
	load_game.set_disabled(true)
